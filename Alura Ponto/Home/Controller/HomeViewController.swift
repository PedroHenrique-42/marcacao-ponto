//
//  HomeViewController.swift
//  Alura Ponto
//
//  Created by Ândriu Felipe Coelho on 22/09/21.
//

import CoreData
import UIKit

class HomeViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var horarioView: UIView!
    @IBOutlet var horarioLabel: UILabel!
    @IBOutlet var registrarButton: UIButton!

    // MARK: - Attributes
    
    private var timer: Timer?
    private lazy var camera = Camera()
    private lazy var controladorDeImagem = UIImagePickerController()
    
    var contexto: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configuraView()
        atualizaHorario()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configuraTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    // MARK: - Class methods
    
    func configuraView() {
        configuraBotaoRegistrar()
        configuraHorarioView()
    }
    
    func configuraBotaoRegistrar() {
        registrarButton.layer.cornerRadius = 5
    }
    
    func configuraHorarioView() {
        horarioView.backgroundColor = .white
        horarioView.layer.borderWidth = 3
        horarioView.layer.borderColor = UIColor.systemGray.cgColor
        horarioView.layer.cornerRadius = horarioView.layer.frame.height / 2
    }
    
    func configuraTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(atualizaHorario), userInfo: nil, repeats: true)
    }
    
    @objc func atualizaHorario() {
        let horarioAtual = FormatadorDeData().getHorario(Date())
        horarioLabel.text = horarioAtual
    }
    
    func tentaAbrirCamera() {
        let podeAbrirCamera = UIImagePickerController.isSourceTypeAvailable(.camera)
        print("Pode abrir a camera? \(podeAbrirCamera ? "Sim" : "Não")")
        if podeAbrirCamera {
            camera.delegate = self
            camera.abrirCamera(self, imagePicker: controladorDeImagem)
        }
    }
    
    func mostraMenuEscolhaDeFoto() {
        let menu = UIAlertController(
            title: "Seleção de foto",
            message: "Escolha uma foto da biblioteca",
            preferredStyle: .actionSheet
        )
        
        menu.addAction(
            .init(
                title: "Biblioteca de fotos",
                style: .default,
                handler: { _ in
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        self.camera.delegate = self
                        self.camera.abrirBibliotecaFotos(self, self.controladorDeImagem)
                    }
                }
            )
        )
        
        menu.addAction(
            .init(
                title: "Cancelar",
                style: .destructive,
                handler: nil
            )
        )
        
        present(menu, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func registrarButton(_ sender: UIButton) {
        mostraMenuEscolhaDeFoto()
    }
}

extension HomeViewController: CameraDelegate {
    func didSelectFoto(_ image: UIImage) {
        let recibo = Recibo(status: false, data: Date(), foto: image)
        recibo.salvar(contexto)
    }
}

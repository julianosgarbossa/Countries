//
//  Untitled.swift
//  TudoSobreCamadaDeNetworkMasterCode
//
//  Created by Caio Fabrini on 18/04/26.
//

import UIKit

private var imageTaskKey: Int = 0
private var imageURLKey: Int = 0
private var loadingIndicatorKey: Int = 0

extension UIImageView {
  
  // Guard a Task da atual requisição da imagem
  // Isso é importante para que a gente cancele o download
  // caso a célula seja recriada
  private var imageTask: URLSessionTask? {
    get { objc_getAssociatedObject(self, &imageTaskKey) as? URLSessionTask }
    set { objc_setAssociatedObject(self, &imageTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }
  
  // Guarda URL da imagem que a imageView está esperando carregar
  // Isso ajuda não pegar uma URL de uma célula que foi recriada
  private var imageURL: String? {
    get { objc_getAssociatedObject(self, &imageURLKey) as? String }
    set { objc_setAssociatedObject(self, &imageURLKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }
  
  private var loadingIndicator: UIActivityIndicatorView {
    if let loading = objc_getAssociatedObject(self, &loadingIndicatorKey) as? UIActivityIndicatorView {
      return loading
    }
    
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    addSubview(indicator)
    
    NSLayoutConstraint.activate([
      indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
    
    objc_setAssociatedObject(self, &loadingIndicatorKey, indicator, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    return indicator
  }
  
  
  func downloadImage(urlString: String,
                     placeholderImage: UIImage? = nil,
                     errorImage: UIImage? = nil,
                     showLoadingIndicator: Bool = true) {
    cancelImageLoad()
    
    // Primeiro mostramos o placeholder caso tenha
    image = placeholderImage
    
    // Guardamos a URL atual que vai para a imageView
    imageURL = urlString
    
    if showLoadingIndicator {
      loadingIndicator.startAnimating()
    }
    
    imageTask = ImageService.shared.download(urlString: urlString, completion: { [weak self] result in
      guard let self else { return }
      
      // Aqui validamos se a URL da resposta é a mesma que está na UIImageView.
      // Isso resolve o problema classico de reuso da celula
      guard imageURL == urlString else { return }
      loadingIndicator.stopAnimating()
      
      switch result {
      case .success(let image):
        // Se deu sucesso, eu exibo a imagem correta
        self.image = image
      case .failure:
        // Se deu error, eu exibo a imagem de error CASO eu tenha informado ela no parâmetro
        self.image = errorImage
      }
    })
    
  }
  
  func cancelImageLoad() {
    // Cancela a task atual, se existir
    imageTask?.cancel()
    
    // Limpa as referencias para evitar estado antigo de outra celula
    imageTask = nil
    imageURL = nil
    
    // Para o loading caso ele esteja ativo
    loadingIndicator.stopAnimating()
  }
}

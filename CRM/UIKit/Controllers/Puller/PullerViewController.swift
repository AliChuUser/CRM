//
//  PullerViewController.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

public class PullerViewController: UIViewController {
		public var onPositionChange: ((CGFloat) -> Void)?
		var contentView: UIView?
		public var contentVC: UIViewController? {
				didSet {
						addChildViewController()
				}
		}
		var parentVC: UIViewController?
		
		// Расстояние от верха
		var topMargin: CGFloat = 60
		var headerHeight: CGFloat = 45
		// Выступ от низа
		var bottomPosition: CGFloat {
				return UIScreen.main.bounds.height - 150
		}
		var bottomPadding: CGFloat = 0
		
		override public func viewDidLoad() {
				super.viewDidLoad()
				
				// Слушаем жесты перетягивания
				let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(PullerViewController.panGesture))
				gesture.delegate = self
				self.view.addGestureRecognizer(gesture)
		}
		
		override public func viewDidAppear(_ animated: Bool) {
				super.viewDidAppear(animated)
				addChildViewController()
				// Анимируем показ как только элемент пуллера встроился в родительский ViewController
				addPullerToSuperview()
				applyPullerTopShadow()
				self.parentVC = self.parent
		}
		
		override public func didReceiveMemoryWarning() {
				super.didReceiveMemoryWarning()
				// Dispose of any resources that can be recreated.
		}
		
		// MARK: - Положения пуллера и жесты
		@objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
				
				let translation = recognizer.translation(in: self.view)
				let velocity = recognizer.velocity(in: self.view)
				let y = self.view.frame.minY
				
				if (y + translation.y >= topMargin) {
						self.moveFrameAcrossY(by: y + translation.y)
						recognizer.setTranslation(CGPoint.zero, in: self.view)
				}

				if recognizer.state == .ended {
						var duration = velocity.y < 0 ? Double((y - topMargin) / -velocity.y) : Double((bottomPosition - y) / velocity.y )
						
						duration = duration > 1.3 ? 1 : duration
						
						UIView.animate(withDuration: duration,
													 delay: 0.0,
													 options: [.allowUserInteraction],
													 animations: {
								if velocity.y >= 0 {
										// Если тянем вниз
										if self.view.frame.minY <= self.bottomPosition {
												// из полностью раскрытого положения
												self.moveFrameAcrossY(by: self.bottomPosition)
										} else {
												// из промежуточного положения
												self.moveFrameAcrossY(by: self.view.frame.height + self.topMargin)
										}
								} else {
										// Если тянем вверх
										self.moveFrameAcrossY(by: self.topMargin)
								}
								
						}, completion: { [weak self] (finished: Bool) in
								if ( velocity.y < 0 ) {
										if let contentView = self?.contentView as? UIScrollView {
												contentView.isScrollEnabled = true
										}
								} else {
										// Удаляем из родителя если пуллер утянут вниз
										self?.removePuller(finished: finished)
								}
						})
				}
		}
		
		// MARK: - Наполнение пуллера содержимым
		private func addChildViewController() {
				guard isViewLoaded, contentView == nil,
						let contentVC = self.contentVC,
						let contentView = contentVC.view else { return }
				
				self.contentView = contentView
				view.addSubview(contentView)
				
				let headerView = UIView()
				headerView.translatesAutoresizingMaskIntoConstraints = false
				headerView.backgroundColor = Colors.white
				view.addSubview(headerView)
				roundCorners([.topLeft, .topRight], radius: 14, view: headerView)
				
				let safeAreaFillerView = UIView()
				safeAreaFillerView.translatesAutoresizingMaskIntoConstraints = false
				safeAreaFillerView.backgroundColor = Colors.white
				view.addSubview(safeAreaFillerView)
				
				let holdView = UIView()
				holdView.translatesAutoresizingMaskIntoConstraints = false
				holdView.backgroundColor = Colors.secondBlazer
				holdView.layer.cornerRadius = 3
				headerView.addSubview(holdView)
				
				contentView.translatesAutoresizingMaskIntoConstraints = false
				
				addChild(contentVC)
				contentVC.didMove(toParent: self)
				
				var contentHeight: CGFloat = 0
				if let contentScrollView = contentView as? UIScrollView {
						contentScrollView.layoutIfNeeded()
						contentHeight = contentScrollView.contentSize.height
				} else {
						contentHeight = contentView.bounds.height
				}
				
				// MARK: - Constraints
				NSLayoutConstraint.activate([
						holdView.heightAnchor.constraint(equalToConstant: 3),
						holdView.widthAnchor.constraint(equalToConstant: 47),
						holdView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 14),
						holdView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
				])
				
				NSLayoutConstraint.activate([
						headerView.heightAnchor.constraint(equalToConstant: headerHeight),
						headerView.topAnchor.constraint(equalTo: view.topAnchor),
						headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
						headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				])
				
				NSLayoutConstraint.activate([
						contentView.heightAnchor.constraint(equalToConstant: contentHeight),
						contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
						contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
						contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
				])
				
				NSLayoutConstraint.activate([
						safeAreaFillerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
						safeAreaFillerView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
						safeAreaFillerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
						safeAreaFillerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
				])
				
		}
		
		func roundCorners(_ corners: UIRectCorner, radius: CGFloat, view: UIView) {
				if #available(iOS 11.0, *) {
						view.clipsToBounds = true
						view.layer.cornerRadius = radius
						view.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
				} else {
						let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
						let mask = CAShapeLayer()
						mask.path = path.cgPath
						view.layer.mask = mask
				}
		}
		
		private func applyPullerTopShadow() {
				view.layer.masksToBounds = false
				view.layer.shadowColor = Colors.pullerShadow.cgColor
				view.layer.shadowRadius = 28
				view.layer.shadowOpacity = 1
				view.layer.shadowOffset = CGSize(width: 0, height: -4)
		}
		
		private func removePuller(finished: Bool) {
				if self.view.frame.minY >= self.view.frame.height && finished {
						self.parentVC?.willMove(toParent: nil)
						self.parentVC?.view.removeFromSuperview()
						self.parentVC?.removeFromParent()
				}
		}
		
		// MARK: - Двигаем пуллер по оси Y
		/// Изменение положения по оси Y и изменение прозрачности фонового затенения
		/// - Parameters:
		///   - y: целевое положение по оси Y для верха пуллера
		///   - initialHeight: высота пуллера (только для 1го появления)
		private func moveFrameAcrossY(by y: CGFloat, initialHeight: CGFloat? = nil) {
				let height = initialHeight ?? view.frame.height
				let constrainedY = max(y, y - height)
				let pullerHeight = y - self.topMargin
				let currentYPosition = self.view.frame.height - pullerHeight
				
				self.view.frame = CGRect(x: 0,
																 y: constrainedY,
																 width: view.frame.width,
																 height: height)
				
				var normalizedY = (currentYPosition / self.view.frame.height) / 2
				normalizedY = normalizedY <= 0.49 ? normalizedY : 0.49
				
				onPositionChange?(normalizedY)
		}
		
		// MARK: - Показ пуллера
		/// Добавление пуллера. Размер завязан на высоту фрейма содержимого.
		public func addPullerToSuperview() {
				
				UIView.animate(withDuration: 0.3, animations: { [weak self] in
						var contentVCHeight: CGFloat = self?.contentVC?.view.frame.height ?? 0
						var yPosition: CGFloat
						guard let topMargin = self?.topMargin else { return }
						
						if #available(iOS 11.0, *) {
								let window = UIApplication.shared.keyWindow
								self?.bottomPadding = window?.safeAreaInsets.bottom ?? 0
						}
						
						let maxContentHeight = UIScreen.main.bounds.height - self!.topMargin - self!.headerHeight - self!.bottomPadding
												
						if let scrollView = self?.contentVC?.view as? UIScrollView {
								contentVCHeight = scrollView.contentSize.height
						} else {
								guard let contentVCView = self?.contentVC?.view else { return }
								contentVCHeight = contentVCView.frame.size.height
						}
						
						// Если содержимое превышает максимальную высоту пуллера, то ограничиваем высоту содержимого
						if contentVCHeight > maxContentHeight {
								contentVCHeight = maxContentHeight
						}
						
						let pullerHeight = contentVCHeight + self!.headerHeight + self!.bottomPadding
						
						// Если высота пуллера превышает максимальную, то ограничиваем верхнее положение пуллера. Если меньше, то присваиваем высоту, подходящую под размер содержимого.
						if pullerHeight > UIScreen.main.bounds.height - topMargin {
								yPosition = UIScreen.main.bounds.height - (UIScreen.main.bounds.height - topMargin)
						} else {
								yPosition = UIScreen.main.bounds.height - pullerHeight
								self?.topMargin = yPosition
						}
						
						self?.moveFrameAcrossY(by: yPosition, initialHeight: pullerHeight)
				})
				
				func computeContentHeight(view: UIView) -> CGFloat {
						var height: CGFloat = 0
						for subview in view.subviews {
								if let scrollView = subview as? UIScrollView {
										height += scrollView.contentSize.height
										print("height1==", height)
								} else {
										height += subview.frame.size.height
										print("height2==", height)
								}
						}
						print("height3==", height)
						return height
				}
				
		}
		
		// MARK: - Удаление пуллера
		public func removePullerFromSuperview() {
				UIView.animate(withDuration: 0.3,
											 delay: 0.0,
											 options: [.allowUserInteraction],
											 animations: {
												
												self.moveFrameAcrossY(by: self.view.frame.height + self.topMargin)
				}, completion: { [weak self] (finished: Bool) in
						self?.removePuller(finished: finished)
				})
		}
		
}

extension PullerViewController: UIGestureRecognizerDelegate {
		public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
				
				guard let contentView = contentView as? UIScrollView else { return false }
				let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
				let direction = gesture.velocity(in: view).y
				
				let y = view.frame.minY
				if (y == topMargin && contentView.contentOffset.y == 0 && direction > 0) || (y == bottomPosition) {
						contentView.isScrollEnabled = false
				} else {
						contentView.isScrollEnabled = true
				}
				
				return false
		}
		
}


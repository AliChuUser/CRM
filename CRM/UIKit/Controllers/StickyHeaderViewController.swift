//
//  StickyHeaderViewController.swift
//  CRM
//
//  Created by Aleksei Chudin on 04.10.2023.
//

import UIKit

/// ViewController с динамическим хэдером, высота которого зависит от положения scrollview
open class StickyHeaderViewController: UIViewController {
		@IBOutlet public weak var scrollView: UIScrollView!
		@IBOutlet public weak var headerViewHeight: NSLayoutConstraint!

		/// Минимальная высота хедера с добавлением safeArea
		private var minimumHeightAdjusted: CGFloat = 0

		/// Минимальная высота хедера (без учета safeArea)
		@IBInspectable public var minimumHeight: CGFloat = 44 {
				didSet {
						updateAdjustedHeaderHeightLimits()
				}
		}

		/// Максимальная высота хедера с добавлением safeArea
		private var maximumHeightAdjusted: CGFloat = 0

		/// Максимальная высота хедера (без учета safeArea)
		@IBInspectable public var maximumHeight: CGFloat = 240 {
				didSet {
						updateAdjustedHeaderHeightLimits()
				}
		}

		/// Высота хедера по умолчанию. Устанавливается как изначальное значение констрейнта 'headerViewHeight'
		public private (set) var defaultHeaderHeight: CGFloat = 0

		/// Текущий вертикальный отступ scrollView. Инвертирован
		public var scrollViewOffsetTop: CGFloat = 0

		/// Изначальный contentInset.top scrollView
		private var scrollViewInitialInsetTop: CGFloat = 0

		/// Текущая фаза сворачивания хедера (0 - минимальная высота, 1 - максимальная)
		public private (set) var phase: CGFloat = 0
		
		// Высота хедера при свёрнутой/развёрнутой панели поиска
		private var expandedSearchHeaderHeight: CGFloat = 184
		private var collapsedSearchHeaderHeight: CGFloat = 128
		
		// Показана ли панель поиска при старте экрана
		public var searchBarShownInBeginning: Bool = false
		
		// Открыта ли панель поиска (нужно, если searchBarShownInBeginning равен false)
		private var isSearchBarOpen: Bool = false

		// MARK: - Lifecycle

		override open func viewDidLoad() {
				super.viewDidLoad()
				if searchBarShownInBeginning {
						headerViewHeight?.constant = expandedSearchHeaderHeight
				} else {
						headerViewHeight?.constant = collapsedSearchHeaderHeight
				}
				
				defaultHeaderHeight = headerViewHeight.constant
				scrollViewInitialInsetTop = scrollView.contentInset.top
				scrollView.contentInset.top += defaultHeaderHeight
				if #available(iOS 11.1, *) {
						scrollView.verticalScrollIndicatorInsets.top = scrollView.contentInset.top
				} else {
						scrollView.scrollIndicatorInsets.top = scrollView.contentInset.top
				}
		}

		override open func viewWillAppear(_ animated: Bool) {
				super.viewWillAppear(animated)
				guard isViewLoaded else { return }
				updateAdjustedHeaderHeightLimits()
				updateHeaderHeight()
		}

		override open func viewDidLayoutSubviews() {
				super.viewDidLayoutSubviews()
				updateAdjustedHeaderHeightLimits()
		}

		// MARK: - StickyHeader methods
		private func updateAdjustedHeaderHeightLimits() {
				minimumHeightAdjusted = minimumHeight + view.safeAreaInsets.top
				maximumHeightAdjusted = maximumHeight + view.safeAreaInsets.top
		}

		open func updateHeaderHeight() {
				guard isViewLoaded else { return }
				let headerHeight = scrollViewOffsetTop - scrollViewInitialInsetTop
				let constrainedHeaderHeight = min(maximumHeightAdjusted, max(minimumHeightAdjusted, headerHeight))
//        print("scrollViewOffsetTop: \(scrollViewOffsetTop)")
//        print("128 + view.safeAreaInsets.top: \(collapsedSearchHeaderHeight + view.safeAreaInsets.top)")
				if !searchBarShownInBeginning && !isSearchBarOpen && (scrollViewOffsetTop > (collapsedSearchHeaderHeight + view.safeAreaInsets.top)) {
						self.headerViewHeight?.constant = expandedSearchHeaderHeight
						self.view.layoutIfNeeded()
						self.isSearchBarOpen = true
						
//            if let headerHeight = self.headerViewHeight?.constant {
//                print("\nheaderHeight: \(headerHeight)\n")
//            }
				} else if searchBarShownInBeginning || isSearchBarOpen || !(scrollViewOffsetTop > (collapsedSearchHeaderHeight + view.safeAreaInsets.top)) {
						headerViewHeight?.constant = constrainedHeaderHeight
				}
				phase = (headerViewHeight.constant - minimumHeightAdjusted) / (defaultHeaderHeight - minimumHeightAdjusted)
		}

		private func setHeaderClosestHeightIfNeeded() {
				guard isViewLoaded, let headerViewHeight = headerViewHeight else { return }
				let phase = (headerViewHeight.constant - minimumHeightAdjusted) / (defaultHeaderHeight - minimumHeightAdjusted)
				var targetHeight: CGFloat?
				switch phase {
				case 0 ..< 0.5:
						targetHeight = minimumHeightAdjusted
						break
				case 0.5 ... 1:
						targetHeight = defaultHeaderHeight
						break
				default:
						targetHeight = nil
				}
				guard targetHeight != nil else { return }

				let diff = targetHeight! - headerViewHeight.constant
				scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + diff), animated: true)
		}
}

// MARK: - UIScrollViewDelegate

extension StickyHeaderViewController: UIScrollViewDelegate {

		open func scrollViewDidScroll(_ scrollView: UIScrollView) {
				guard isViewLoaded else { return }
				let actualOffset = scrollView.contentOffset.y * -1
				scrollViewOffsetTop = actualOffset
				
				updateHeaderHeight()
		}

		// TODO: 20.11.2019 Сделать автоматический скролл до ближайшей высоты хедера
//    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        setHeaderClosestHeightIfNeeded()
//    }
//
//    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        setHeaderClosestHeightIfNeeded()
//    }
}


//
//  SegmentControlCell.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.12.2023.
//

import Foundation
import UIKit

public class SegmentControlCell: TableBaseCell {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont(name: "HelveticaNeue", size: 13)
            titleLabel.textColor = Colors.blueyGrey
        }
    }

    @IBOutlet weak var segment1: UIButton! {
        didSet {
            guard  let image = UIImage(named: "exclamationMark") else { return }
            setStyleSegment(segment: segment1, color: Colors.coralPink, image: image)
        }
    }
    @IBOutlet weak var segment2: UIButton!{
        didSet {
            guard let image = UIImage(named: "twoExclamationMark") else { return }
            setStyleSegment(segment: segment2, color: Colors.coralPink, image: image)
        }
    }

    @IBOutlet weak var segment3: UIButton!{
        didSet {
            guard let image = UIImage(named: "threeExclamationMark") else { return }
            setStyleSegment(segment: segment3, color: Colors.coralPink, image: image)
        }
    }

    private func setStyleSegment(segment: UIButton, color: UIColor, image: UIImage?) {
        if let image = image {
            segment.setImage(image, for: .normal)
        }
        segment.setTitle("", for: .normal)
        segment.tintColor = color
        segment.layer.borderWidth = 1
        segment.layer.borderColor = color.cgColor
    }

    @IBOutlet weak var separatorLine: UIView!{
        didSet {
            separatorLine.backgroundColor = Colors.separatorLine
        }
    }

    public override func updateAppearance() {
        super.updateAppearance()
        guard let model = model as? SegmentControlCellModel else { return }
        selectionStyle = .none
        titleLabel.text = model.title
        if model.isDisabled {
            segment1.isUserInteractionEnabled = false
            setStyleSegment(segment: segment1, color: Colors.palePurple, image: nil)
            segment2.isUserInteractionEnabled = false
            setStyleSegment(segment: segment2, color: Colors.palePurple, image: nil)
            segment3.isUserInteractionEnabled = false
            setStyleSegment(segment: segment3, color: Colors.palePurple, image: nil)

            switch model.isSelectedSegment {
            case 0:
                break
            case 1:
                setSegmentDisabled(activeSegment: segment1, deactiveSegment2: segment2, deactiveSegment3: segment3)
            case 2:
                setSegmentDisabled(activeSegment: segment2, deactiveSegment2: segment1, deactiveSegment3: segment3)
            case 3:
                setSegmentDisabled(activeSegment: segment3, deactiveSegment2: segment1, deactiveSegment3: segment2)
            default:
                break
            }
        } else {
            switch model.isSelectedSegment {
            case 0:
                break
            case 1:
                setSegmentActive(activeSegment: segment1, deactiveSegment2: segment2, deactiveSegment3: segment3)
            case 2:
                setSegmentActive(activeSegment: segment2, deactiveSegment2: segment1, deactiveSegment3: segment3)
            case 3:
                setSegmentActive(activeSegment: segment3, deactiveSegment2: segment1, deactiveSegment3: segment2)
            default:
                break
            }
        }
    }

    var selectedSegmentIndex: Int = 0


    private func setSegmentDisabled(activeSegment: UIButton, deactiveSegment2: UIButton, deactiveSegment3: UIButton) {
        activeSegment.tintColor = Colors.white
        activeSegment.backgroundColor = Colors.palePurple

        deactiveSegment2.backgroundColor = Colors.white
        deactiveSegment2.tintColor = Colors.palePurple

        deactiveSegment3.backgroundColor = Colors.white
        deactiveSegment3.tintColor = Colors.palePurple
    }

    private func setSegmentActive(activeSegment: UIButton, deactiveSegment2: UIButton, deactiveSegment3: UIButton) {
        activeSegment.tintColor = Colors.white
        activeSegment.backgroundColor = Colors.coralPink

        deactiveSegment2.backgroundColor = Colors.white
        deactiveSegment2.tintColor = Colors.coralPink

        deactiveSegment3.backgroundColor = Colors.white
        deactiveSegment3.tintColor = Colors.coralPink
    }

    private func setSegmentDeactivate(deactiveSegment: UIButton) {
        guard let model = model as? SegmentControlCellModel else { return }
        model.onSegmentChange?(nil)
        deactiveSegment.backgroundColor = Colors.white
        deactiveSegment.tintColor = Colors.coralPink
        selectedSegmentIndex = 0
    }

    private func segmentTap(activeSegment: UIButton, deactiveSegment2: UIButton, deactiveSegment3: UIButton) {
        guard let model = model as? SegmentControlCellModel else { return }
        if selectedSegmentIndex == 1 {
            model.onSegmentChange?(1)
            setSegmentActive(activeSegment: activeSegment, deactiveSegment2: deactiveSegment2, deactiveSegment3: deactiveSegment3)
        }  else if selectedSegmentIndex == 2 {
            model.onSegmentChange?(2)
            setSegmentActive(activeSegment: activeSegment, deactiveSegment2: deactiveSegment2, deactiveSegment3: deactiveSegment3)
        } else if selectedSegmentIndex == 3 {
            model.onSegmentChange?(3)
            setSegmentActive(activeSegment: activeSegment, deactiveSegment2: deactiveSegment2, deactiveSegment3: deactiveSegment3)
        }
    }

    @IBAction func segment1Action(_ sender: UIButton) {
        if selectedSegmentIndex == 1 {
            setSegmentDeactivate(deactiveSegment: segment1)
        } else {
            selectedSegmentIndex = 1
            segmentTap(activeSegment: segment1, deactiveSegment2: segment2, deactiveSegment3: segment3)
        }
    }

    @IBAction func segment2Action(_ sender: UIButton) {
        if selectedSegmentIndex == 2 {
            setSegmentDeactivate(deactiveSegment: segment2)
        } else {
            selectedSegmentIndex = 2
            segmentTap(activeSegment: segment2, deactiveSegment2: segment1, deactiveSegment3: segment3)
        }
    }

    @IBAction func segment3Action(_ sender: UIButton) {
        if selectedSegmentIndex == 3 {
            setSegmentDeactivate(deactiveSegment: segment3)
        } else {
            selectedSegmentIndex = 3
            segmentTap(activeSegment: segment3, deactiveSegment2: segment1, deactiveSegment3: segment2)
        }
    }
}

//
//  ViewController.swift
//  Project 6
//
//  Created by Ammad on 18/08/2020.
//  Copyright © 2020 Ammad. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        createVFL()
//        createAnchors()
//        createStackView()
        createGridView()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func makeView(_ number: Int) -> NSView {
        let view = NSTextField(labelWithString: "View #\(number)")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.cyan.cgColor
        
        return view
    }
    
    func createVFL() {
        // Set up a dictionary of strings and views
        let textFields = [
            "view0": makeView(0),
            "view1": makeView(1),
            "view2": makeView(2),
            "view3": makeView(3)]
        
        // Loop over each item
        for (name, textField) in textFields {
            // Add it to our view
            view.addSubview(textField)
            
            // Add horizontal constraints saying that this view should stretch from edge to edge
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(name)]|", options: [], metrics: nil, views: textFields))
        }
        
        // Add another set of constraints that cause the views to be aligned vertically, one above the other
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view0]-[view1]-[view2]-[view3]|", options: [], metrics: nil, views: textFields))
    }
    
    func createAnchors() {
        // Create a variable to track the previous view we placed
        var previous: NSView!
        
        // Create a four views and put them into an array
        let views = [makeView(0), makeView(1), makeView(2), makeView(3)]
        
        for vw in views {
            // Add this child to our main view, making it fill the horizontal space and be 88 points high
            view.addSubview(vw)
            vw.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            vw.heightAnchor.constraint(equalToConstant: 88).isActive = true
            vw.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            
            if previous != nil {
                // We have a previous view - position us 10 points vertically away from it
                vw.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                // We don't have a previous view - position us against the top edge
                vw.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            }
            
            // Set the previous view to be current one, for the next loop iteration
            previous = vw
        }
        
        // Make the final view sit against the bottom edge of our main view
        previous.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func createStackView() {
        // Create a stack view from four text fields
        let stackView = NSStackView(views: [makeView(0), makeView(1), makeView(2), makeView(3)])
        
        // Make them take up an equal amount of space
        stackView.distribution = .fillEqually
        
        // Make the views line up vertically
        stackView.orientation = .vertical
        
        // Set this to false so we can create our own Auto Layout constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        for view in stackView.arrangedSubviews {
            view.setContentHuggingPriority(NSLayoutConstraint.Priority(1), for: .horizontal)
            view.setContentHuggingPriority(NSLayoutConstraint.Priority(1), for: .vertical)
        }
        
        // Make the stack view sit directly against all four edges
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func createGridView() {
        // Create our concise empty cell
        let empty = NSGridCell.emptyContentView
        
        // Create a grid of views
        let gridView = NSGridView(views: [
            [makeView(0)],
            [makeView(1), empty, makeView(2)],
            [makeView(3), makeView(4), makeView(5), makeView(6)],
            [makeView(7), empty, makeView(8)],
            [makeView(9)]
        ])
        
        // Mark that we'll creare our own constraints
        gridView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridView)
        
        // Pin the grid to the edges of our main view
        gridView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gridView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gridView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gridView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        gridView.row(at: 0).height = 32
        gridView.row(at: 1).height = 32
        gridView.row(at: 2).height = 32
        gridView.row(at: 3).height = 32
        gridView.row(at: 4).height = 32
        
        gridView.column(at: 0).width = 128
        gridView.column(at: 1).width = 128
        gridView.column(at: 2).width = 128
        gridView.column(at: 3).width = 128
        
        gridView.row(at: 0).mergeCells(in: NSRange(location: 0, length: 4))
        gridView.row(at: 1).mergeCells(in: NSRange(location: 0, length: 2))
        gridView.row(at: 1).mergeCells(in: NSRange(location: 2, length: 2))
        gridView.row(at: 3).mergeCells(in: NSRange(location: 0, length: 2))
        gridView.row(at: 3).mergeCells(in: NSRange(location: 2, length: 2))
        gridView.row(at: 4).mergeCells(in: NSRange(location: 0, length: 4))
        
        gridView.row(at: 0).yPlacement = .center
        gridView.row(at: 1).yPlacement = .center
        gridView.row(at: 2).yPlacement = .center
        gridView.row(at: 3).yPlacement = .center
        gridView.row(at: 4).yPlacement = .center
        gridView.column(at: 0).xPlacement = .center
        gridView.column(at: 1).xPlacement = .center
        gridView.column(at: 2).xPlacement = .center
        gridView.column(at: 3).xPlacement = .center
    }
}

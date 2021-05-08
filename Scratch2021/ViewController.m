//
//  ViewController.m
//  Scratch2021
//
//  Created by Don Mag on 5/7/21.
//

//#import "ViewController.h"

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@end

@interface ViewController ()

@property (strong, nonatomic) NSLayoutConstraint *collapsedConstraint;
@property (strong, nonatomic) NSLayoutConstraint *expandedConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIStackView *labelsStackView = [UIStackView new];
	labelsStackView.axis = UILayoutConstraintAxisVertical;
	labelsStackView.spacing = 4;
	
	// let's add 12 labels to the stack view (12 "rows")
	for (int i = 1; i < 12; i++) {
		UILabel *v = [UILabel new];
		v.text = [NSString stringWithFormat:@"Label %d", i];
		[labelsStackView addArrangedSubview:v];
	}
	
	// add a view to show above the stack view
	UIView *redView = [UIView new];
	redView.backgroundColor = [UIColor redColor];
	
	// add a view to show below the stack view
	UIView *blueView = [UIView new];
	blueView.backgroundColor = [UIColor blueColor];

	// add a "container" view for the stack view
	UIView *cView = [UIView new];
	
	// clip the container's subviews
	cView.clipsToBounds = YES;
	
	for (UIView *v in @[redView, cView, blueView]) {
		v.translatesAutoresizingMaskIntoConstraints = NO;
		[self.view addSubview:v];
	}
	
	// add the stackView to the container
	labelsStackView.translatesAutoresizingMaskIntoConstraints = NO;
	[cView addSubview:labelsStackView];
	
	// constraints
	UILayoutGuide *g = [self.view safeAreaLayoutGuide];
	
	// when expanded, we'll use the full height of the stack view
	_expandedConstraint = [cView.bottomAnchor constraintEqualToAnchor:labelsStackView.bottomAnchor];
	
	// when collapsed, we'll use the bottom of the 3rd label in the stack view
	UILabel *v = labelsStackView.arrangedSubviews[2];
	_collapsedConstraint = [cView.bottomAnchor constraintEqualToAnchor:v.bottomAnchor];
	
	// start collapsed
	_expandedConstraint.priority = UILayoutPriorityDefaultLow;
	_collapsedConstraint.priority = UILayoutPriorityDefaultHigh;
	
	[NSLayoutConstraint activateConstraints:@[
		
		// redView Top / Leading / Trailing / Height=120
		[redView.topAnchor constraintEqualToAnchor:g.topAnchor constant:20.0],
		[redView.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20.0],
		[redView.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20.0],
		[redView.heightAnchor constraintEqualToConstant:120.0],
		
		// container Top==redView.bottom / Leading / Trailing / no height
		[cView.topAnchor constraintEqualToAnchor:redView.bottomAnchor constant:0.0],
		[cView.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20.0],
		[cView.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20.0],
		
		// blueView Top==stackView.bottom / Leading / Trailing / Height=160
		[blueView.topAnchor constraintEqualToAnchor:cView.bottomAnchor constant:0.0],
		[blueView.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20.0],
		[blueView.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20.0],
		[blueView.heightAnchor constraintEqualToConstant:160.0],
		
		// stackView Top / Leading / Trailing
		[labelsStackView.topAnchor constraintEqualToAnchor:cView.topAnchor],
		[labelsStackView.leadingAnchor constraintEqualToAnchor:cView.leadingAnchor],
		[labelsStackView.trailingAnchor constraintEqualToAnchor:cView.trailingAnchor],

		_expandedConstraint,
		_collapsedConstraint,
		
	]];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

	// toggle priority between expanded / collapsed constraints
	if (_expandedConstraint.priority == UILayoutPriorityDefaultHigh) {
		_expandedConstraint.priority = UILayoutPriorityDefaultLow;
		_collapsedConstraint.priority = UILayoutPriorityDefaultHigh;
	} else {
		_collapsedConstraint.priority = UILayoutPriorityDefaultLow;
		_expandedConstraint.priority = UILayoutPriorityDefaultHigh;
	}
	// animate the change
	[UIView animateWithDuration:0.5 animations:^{
		[self.view layoutIfNeeded];
	}];
	
}

@end

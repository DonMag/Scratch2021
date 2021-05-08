//
//  MyListView.m
//  Scratch2021
//
//  Created by Don Mag on 5/7/21.
//

#import "MyListView.h"

@interface MyListView ()

@property (strong, nonatomic) UIStackView *stack;
@property (strong, nonatomic) UIView *stackContainer;

@property (strong, nonatomic) NSArray<ListElement *> *listData;

@end

@implementation MyListView

- (instancetype)initWithTitle:(NSArray<ListElement *> *)listData {
	if (self = [super initWithFrame:CGRectZero]) {
		self.listData = listData;
		
		_stackContainer = [UIView new];
		_stack = [UIStackView new];
		_stack.axis = UILayoutConstraintAxisVertical;
		_stack.spacing = 4;
		
		_stack.translatesAutoresizingMaskIntoConstraints = NO;
		_stackContainer.translatesAutoresizingMaskIntoConstraints = NO;
		
		[_stackContainer addSubview:_stack];
		
		for (ListElement *e in listData) {
			UIStackView *st = [UIStackView new];
			st.spacing = 4;
			st.alignment = UIStackViewAlignmentTop;
			st.distribution = UIStackViewDistributionFillEqually;
			UILabel *v = [UILabel new];
			v.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightBold];
			v.text = e.title;
			[st addArrangedSubview:v];
			v = [UILabel new];
			v.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
			v.text = e.data;
			[st addArrangedSubview:v];
			[_stack addArrangedSubview:st];
		}
		[NSLayoutConstraint activateConstraints:@[
			[_stack.topAnchor constraintEqualToAnchor:[self topAnchor]],
			[_stack.leadingAnchor constraintEqualToAnchor:[self leadingAnchor]],
			[_stack.trailingAnchor constraintEqualToAnchor:[self trailingAnchor]],
			[_stack.bottomAnchor constraintEqualToAnchor:[self bottomAnchor]],
		]];
	}
	return self;
}

@end

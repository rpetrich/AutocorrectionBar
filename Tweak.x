#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

%hook UIKeyboardCandidateBar

- (void)_showExtendedCandidatesView
{
	// Knope!
}

- (void)layout
{
	%orig;
	UIView **m_extendedButton = CHIvarRef(self, m_extendedButton, UIView *);
	if (m_extendedButton) {
		(*m_extendedButton).hidden = YES;
	}
	UIView **m_shadowView = CHIvarRef(self, m_shadowView, UIView *);
	if (m_shadowView) {
		(*m_shadowView).hidden = YES;
	}
	UIScrollView **m_scrollView = CHIvarRef(self, m_scrollView, UIScrollView *);
	if (m_scrollView) {
		(*m_scrollView).frame = (*m_scrollView).superview.bounds;
		(*m_scrollView).bounces = YES;
	}
}

%end

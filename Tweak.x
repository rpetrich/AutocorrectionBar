#import <UIKit/UIKit.h>
#import <CaptainHook/CaptainHook.h>

%hook UIKeyboardCandidateBar

- (void)_showExtendedCandidatesView
{
	UIMenuController *mc = [UIMenuController sharedMenuController];
	UIView **m_extendedButton = CHIvarRef(self, m_extendedButton, UIView *);
	if (m_extendedButton)
		[mc setTargetRect:(*m_extendedButton).bounds inView:*m_extendedButton];
	[mc setMenuVisible:!mc.menuVisible animated:YES];
}

- (void)layout
{
	%orig;
	BOOL showActionMenuButton = [[[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.rpetrich.autocorrectionbar.plist"] objectForKey:@"ShowActionMenuButton"] boolValue];
	UIView **m_extendedButton = CHIvarRef(self, m_extendedButton, UIView *);
	if (m_extendedButton) {
		(*m_extendedButton).hidden = !showActionMenuButton;
	}
	UIView **m_shadowView = CHIvarRef(self, m_shadowView, UIView *);
	if (m_shadowView) {
		(*m_shadowView).hidden = !showActionMenuButton;
	}
	UIScrollView **m_scrollView = CHIvarRef(self, m_scrollView, UIScrollView *);
	if (m_scrollView) {
		CGRect frame = (*m_scrollView).superview.bounds;
		if (showActionMenuButton && m_extendedButton) {
			frame.size.width -= (*m_extendedButton).frame.size.width;
		}
		(*m_scrollView).frame = frame;
		(*m_scrollView).bounces = YES;
	}
}

%end

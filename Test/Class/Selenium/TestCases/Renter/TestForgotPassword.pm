package Test::Class::Selenium::TestCases::Renter::TestForgotPassword;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::ForgotPasswordPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::Renter::Renter';

=head1 NAME

TestForgotPassword - This Test Class verifies the forgot password page for renters

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_submit_valid_email

Verify user enters a valid email address and clicks submit.

Test Steps:

=over

=item 1. Click on 'Forgot password'

=item 2. Type valid email

=item 3. Press Enter

=back

Expected Result:

Username gets submited and proper messaging gets displayed.

=cut

sub test_submit_valid_email: Test(no_plan)
{
	my($self) = @_;	
	
	my $forgotpasswordpage = Test::Class::Selenium::PageObjects::ForgotPasswordPage->new($self);
	$forgotpasswordpage->go_to_forgot_password_page();	
	$forgotpasswordpage->enter_email_address($self->{cpa_username});
	ok($forgotpasswordpage->is_text_present("Thank you!"), 'Verify \'Thank you!\' message');
	ok($forgotpasswordpage->is_text_present("We've sent you an email regarding the information you've requested."), 'Verify \'We\'ve sent you an email regarding the information you\'ve requested.\' message');
}

=head3 test_submit_nonexistant_valid_email

Verify user enters a non-existant email address and clicks submit.

Test Steps:

=over

=item 1. Click on 'Forgot password'

=item 2. Type valid format non-existant email

=item 3. Press Enter

=back

Expected Result:

Username gets submited and proper messaging gets displayed.

=cut

sub test_submit_nonexistant_validformat_email: Test(no_plan)
{
	my($self) = @_;	
	
	my $forgotpasswordpage = Test::Class::Selenium::PageObjects::ForgotPasswordPage->new($self);
	$forgotpasswordpage->go_to_forgot_password_page();	
	$forgotpasswordpage->enter_email_address("ThisEmailDoesNotExist\@rent.com");
	
	ok($forgotpasswordpage->is_text_present("The email address entered did not match an account in our file."), 'Verify email does not exist message');
}

=head3 test_submit_incorrect_format_email

Verify user enters a valid bogus email address  and clicks submit.

Test Steps:

=over

=item 1. Click on 'Forgot password'

=item 2. Enter '!@#$%^&*' in email

=item 3. Press Enter

=back

Expected Result:

Username gets submitted and proper messaging gets displayed.

=cut

sub test_submit_incorrect_format_email: Test(no_plan)
{
	my($self) = @_;	
	
	my $forgotpasswordpage = Test::Class::Selenium::PageObjects::ForgotPasswordPage->new($self);
	$forgotpasswordpage->go_to_forgot_password_page();	
	$forgotpasswordpage->enter_email_address("!@#$%^&*");
	
	ok($forgotpasswordpage->is_text_present("Please enter a valid email address (i.e. user\@domain.com)."), 'Verify incorrect format email message');
}

1;

}
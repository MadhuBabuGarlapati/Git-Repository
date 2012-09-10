package Test::Class::Selenium::PageObjects::ForgotPasswordPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	BUTTON_FORGOTPASSWORD => "forgot_password",
	TFIELD_EMAIL => "document.forms['pwdBox'].elements['email']",
	BUTTON_SUBMIT => "name=submit"
};

=head1 NAME

ForgotPasswordPage

=head1 SYNOPSIS

pageobjects::LandingPage Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with the Forgot Password page.  The page
allows users to enter their email address to retrieve their forgotten password

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $landingpage= pageobjects::LandingPage-E<gt>new( %args )

Constructs a new C<pageobjects::LandingPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";

    return $self;
}	

=item $landingpage-E<gt>go_to_forgot_password_page()

Navigate to forgot password page.

=cut	

sub go_to_forgot_password_page {
    my ( $self ) = @_;

	$self->click(BUTTON_FORGOTPASSWORD);
	$self->wait_for_page_to_load($self->get_page_timeout());

};

=item $landingpage-E<gt>type_email_address()

Type in email address.

=cut	

sub type_email_address {
	my ( $self, $username ) = @_;

	$self->type(TFIELD_EMAIL, $username);
}

=item $landingpage-E<gt>type_email_address()

Type in email address and press enter,
'10' is Enter. (For more info goto: http://download.oracle.com/javase/1.4.2/docs/api/constant-values.html#java.awt.event.KeyEvent.VK_ENTER)

=cut	

sub enter_email_address {
	my ( $self, $username ) = @_;
	
	$self->type(TFIELD_EMAIL, $username);
	$self->click_submit();
}

=item $landingpage-E<gt>click_submit()

Click Submit.  '10' is enter.  http://download.oracle.com/javase/1.4.2/docs/api/constant-values.html#java.awt.event.KeyEvent.VK_ENTER
This is used to get rid of the pop-up in FF3.

=cut

sub click_submit {
	my ( $self) = @_;

	$self->click(BUTTON_SUBMIT);
	$self->wait_for_page_to_load($self->get_page_timeout());
}

1;

}
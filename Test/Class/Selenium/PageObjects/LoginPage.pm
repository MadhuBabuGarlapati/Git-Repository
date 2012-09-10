package Test::Class::Selenium::PageObjects::LoginPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	LINK_SIGNIN => "Sign In",
	TFIELD_EMAIL => "//div[\@id='html_body']/center/div/table/tbody/tr[2]/td[1]/table/tbody/tr[5]/td[3]/input[1]",
	TFIELD_PASSWD => "//div[\@id='html_body']/center/div/table/tbody/tr[2]/td[1]/table/tbody/tr[5]/td[3]/input[2]",
	BUTTON_SIGNIN => "//input[\@type='image']"
};

=head1 NAME

LoginPage

=head1 SYNOPSIS

pageobjects::LoginPage Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with the Login (Sign In) page.  The page
allows users to enter their username and password information and sign in to the application.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $loginpage= pageobjects::LoginPage-E<gt>new( %args )

Constructs a new C<pageobjects::LoginPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}

=item $loginpage-E<gt>login_as($username, $password)

Login with username and password

=cut

sub login_as {
    my ( $self, $username, $password ) = @_;
		
	$self->open("/account/login/");
	$self->certificate_error_handler();		
	$self->enter_user_name($username);
	$self->enter_password($password);
	$self->click(BUTTON_SIGNIN);
	$self->wait_for_page_to_load($self->get_page_timeout());
	
	print ("\n#logged in as: ".$username."\\".$password."\n");
};

=item $loginpage-E<gt>enter_user_name($username)

Types in username

=cut
	
sub enter_user_name {
	my ( $self, $userName ) = @_;
			
	$self->type(TFIELD_EMAIL, $userName);		
};

=item $loginpage-E<gt>enter_user_name($password)

Types in username

=cut

sub enter_password {
	my ( $self, $password ) = @_;
	
	$self->type(TFIELD_PASSWD, $password);		
};

1;

}



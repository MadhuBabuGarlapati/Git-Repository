package Test::Class::Selenium::PageObjects::AccountProfilePage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	TFIELD_FNAME => "first_name-acct",
	TFIELD_LNAME => "last_name-acct",
	TFIELD_USERNAME => "email-acct",	
	TFIELD_PHONENUM => "phone-acct",
	TFIELD_PASSWD => "password-acct",
	BUTTON_SAVECHANGES => "saveChanges_bttn"
};

=head1 NAME

LoginPage

=head1 SYNOPSIS

pageobjects::LoginPage Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with the Account Profile page.  The page
allows users to enter and update their account profile.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $accountprofilepage= pageobjects::AccountProfilePage-E<gt>new( %args )

Constructs a new C<pageobjects::AccountProfilePage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}

=item $accountprofilepage-E<gt>go_to_account_profile()

Go to Account profile page

=cut

sub go_to_account_profile {
    my ( $self ) = @_;
		
	$self->open("/account/profile/");
	
};

=item $accountprofilepage-E<gt>update_phone_number($username)

Update account phone number

=cut
	
sub update_contact_info {
	my ( $self, $fname, $lname, $username, $phonenumber, $password ) = @_;
			
	$self->type(TFIELD_FNAME, $fname);
	$self->type(TFIELD_LNAME, $lname);
	$self->type(TFIELD_USERNAME, $username);
	$self->click(TFIELD_FNAME);
	$self->type(TFIELD_PHONENUM, $phonenumber);	
	$self->type(TFIELD_PASSWD, $password);		
	$self->key_press_up_arrow(TFIELD_FNAME);
	$self->click(BUTTON_SAVECHANGES);	
	$self->wait_for_page_to_load($self->get_page_timeout());

};

1;

}


package Test::Class::Selenium::PageObjects::LeaseAddressPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {	
	RBUTTON_NEW_ADDRESS => "//input[\@id='lease_has_different_reward_card_address' and \@name='lease_has_different_reward_card_address' and \@value='0']",
	RBUTTON_DIFF_ADDRESS => "//input[\@id='lease_has_different_reward_card_address' and \@name='lease_has_different_reward_card_address' and \@value='1']",
	TFIELD_RC_STREET_ADDRESS => "lease_rewardcardaddress_nm",
	TFIELD_RC_UNIT_NUMBER => "lease_rewardcardunit_nb",
	TFIELD_RC_CITY => "lease_rewardcardcity_nm",
	DD_RC_STATE => "lease_rewardcardstate_cd",
	TFIELD_RC_ZIP => "lease_rewardcardzip_cd",
	TFIELD_RC_PHONE_NUMBER => "lease_renterphone_cd",
	BUTTON_SAVEANDVIEWSTATUS => "submit"
};

=head1 NAME

LeaseAddressPage

=head1 SYNOPSIS

pageobjects::LeaseAddressPage

=head1 DESCRIPTION

This class encapsulates the functionality associated with the Lease Address page.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $leaseaddresspage= pageobjects::LeaseAddressPage-E<gt>new( %args )

Constructs a new C<pageobjects::LeaseAddressPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

sub specify_move_in_address()
{
	my ( $self ) = @_;
	
	$self->click(RBUTTON_NEW_ADDRESS);
}

sub specify_reward_card_address()
{
	my ( $self, $street_address, $unit_num, $city, $state, $zip, $phone_num ) = @_;
	
	$self->click(RBUTTON_DIFF_ADDRESS);
	
	# Input new address only if user has done an initial switch from Move In address to Reward Card address
	# Reward Card address for subsequent switches will be retained and do not need to be replaced
	if ( $street_address ne "" )
	{
		$self->click(TFIELD_RC_STREET_ADDRESS);
		$self->type(TFIELD_RC_STREET_ADDRESS, $street_address);
		$self->click(TFIELD_RC_UNIT_NUMBER);
		$self->type(TFIELD_RC_UNIT_NUMBER, $unit_num);
		$self->click(TFIELD_RC_CITY);
		$self->type(TFIELD_RC_CITY, $city);
		$self->select(DD_RC_STATE, "label=".$state);
		$self->click(TFIELD_RC_ZIP);
		$self->type(TFIELD_RC_ZIP, $zip);
		$self->click(TFIELD_RC_PHONE_NUMBER);
		$self->type(TFIELD_RC_PHONE_NUMBER, $phone_num);
	}
}

sub save_address()
{
	my ( $self ) = @_;
	
	$self->click(BUTTON_SAVEANDVIEWSTATUS);
	$self->wait_for_page_to_load($self->get_page_timeout());
}

1;

}
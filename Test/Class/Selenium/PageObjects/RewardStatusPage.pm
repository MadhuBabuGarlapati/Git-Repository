package Test::Class::Selenium::PageObjects::RewardStatusPage;

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

RewardStatusPage

=head1 SYNOPSIS

pageobjects::RewardStatusPage

=head1 DESCRIPTION

This class encapsulates the functionality associated with the Reward Status page.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $rewardstatuspage= pageobjects::RewardStatusPage-E<gt>new( %args )

Constructs a new C<pageobjects::RewardStatusPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

sub get_reward_status_message()
{
	my ( $self, $lease_status, $move_in_date, $property_name ) = @_;
	
	my $status_msg = "## Status message not returned. ##";  # return a default status message
	
	my %status_msgs = (
			"Pre-Confirming" => "On ".$move_in_date.", we will contact ".$property_name." to verify your lease.",
			"Confirming" => "We are in the process of verifying your lease with ".$property_name.".", 
			"Researching" => "We are verifying your lease with ".$property_name.".",
			"Invalid - Late" => "You have up to 90 days from your move-in date to claim your Rent.com \$100 Reward Card."
		);
	$status_msg = $status_msgs{$lease_status};
	
	return $status_msg;
}

1;

}

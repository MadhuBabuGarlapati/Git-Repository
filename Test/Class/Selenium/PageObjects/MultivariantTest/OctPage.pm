package Test::Class::Selenium::PageObjects::MultivariantTest::OctPage;

use strict;
use warnings;

use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	OCTPAGE_URL => "/mvtest/oct.html",
	TFIELD_USERID => "name=user_id",
	BUTTON_SUBMITQUERY => "css=input[type=\"submit\"]"
};

=head1 NAME

OctPage

=head1 SYNOPSIS

pageobjects::Multivariant::OctPage

=head1 DESCRIPTION

This class encapsulates the functionality associated with the multivariant octomber  page.  The page
allows the tech team to view and set picks for multivariant testing.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $landingpage= pageobjects::Multivariant::OctPage-E<gt>new( %args )

Constructs a new C<pageobjects::Multivariant::OctPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	
=item $landingpage-E<gt>}homepage_set_pick()

Set Homepage pick.  This would normally be done in the PickDao DAO, but
Homepage picks are set at the user level and need to be set prior to 
executing new renter registration test cases.

=cut

sub homepage_set_pick {
	my ( $self, $user_id ) = @_;
	
	$self->open(OCTPAGE_URL);
	$self->type(TFIELD_USERID, $user_id);
	$self->click(BUTTON_SUBMITQUERY);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

1;

}

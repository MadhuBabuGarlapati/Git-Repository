package Test::Class::Selenium::PageObjects::LoggedOut::LoggedOutPropertyDescriptionPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {

};

=head1 NAME

LoggedOutPropertyDescriptionPage

=head1 SYNOPSIS

PageObjects::LoggedOut::LoggedOutPropertyDescriptionPage Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with the logged out page.  This is the page
that is viewed when users try to view properties while logged out.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $loggedoutpdp= pageobjects::LoggedOutPDP-E<gt>new( %args )

Constructs a new C<pageobjects::LoggedOutPDP> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}

1;

}



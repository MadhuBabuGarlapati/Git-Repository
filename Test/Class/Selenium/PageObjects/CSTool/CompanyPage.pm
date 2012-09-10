package Test::Class::Selenium::PageObjects::CSTool::CompanyPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::CSTool::CSToolBasePage';

use constant {

	LINK_CREATEPROPERTY => "link=CREATE COMPANY",

};

=head1 NAME

CompanyPage

=head1 SYNOPSIS

Test::Class::Selenium::PageObjects::CSTool::CompanyPage

=head1 DESCRIPTION

This class encapsulates the functionality associated with the CSTool company tab.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $landingpage= Test::Class::Selenium::PageObjects::CSTool::CompanyPage-E<gt>new( %args )

Constructs a new C<Test::Class::Selenium::PageObjects::CSTool::CompanyPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=item $PropertyPage-E<gt>click_create_property()

Click create property link

=cut	

sub click_create_company {
    my ( $self ) = @_;

	$self->click(LINK_CREATEPROPERTY);
	$self->wait_for_page_to_load($self->get_page_timeout()); 

};

1;

}
package Test::Class::Selenium::PageObjects::CSTool::CSToolBasePage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	LINK_PROPERTY => "link=PROPERTY",
	LINK_CONTRACT => "link=CONTRACT",
	LINK_PERSON => "link=PERSON",
	LINK_LEASE => "link=LEASE",
	LINK_ARINVOICE => "link=AR INVOICE",
	LINK_REWARDCARD => "link=REWARD CARD",
	LINK_LANDMARK => "link=LANDMARK",
	LINK_COMPANY => "link=COMPANY",
	LINK_PROMO => "link=PROMO",
	LINK_CAMPAIGN => "link=CAMPAIGN",
	LINK_SOURCE => "link=SOURCE",
	LINK_STATE => "link=STATE",
	LINK_MARKET => "link=MARKET",
	LINK_SUBMARKET => "link=SUBMARKET",
	LINK_AREA => "link=AREA",
	LINK_NEWCONTENT => "link=NEW CONTENT",
};

=head1 NAME

LandingPage

=head1 SYNOPSIS

pageobjects::CSTool::CSToolBasePage Package

=head1 DESCRIPTION

This class encapsulates the CS-Tool page headers
=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	



=item $cstoolbasepage-E<gt>}click_property_tab()

Click property tab

=cut

sub click_property_tab {
	my ( $self ) = @_;
	
	#$self->{selenium}->{browser}->click(LINK_PROPERTY);
	$self->click(LINK_PROPERTY);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

=item $cstoolbasepage-E<gt>}click_contract_tab()

Click contract tab

=cut

sub click_contract_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_CONTRACT);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

=item $cstoolbasepage-E<gt>}click_person_tab()

Click person tab

=cut

sub click_person_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_PERSON);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

=item $cstoolbasepage-E<gt>}click_lease_tab()

Click lease tab

=cut

sub click_lease_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_LEASE);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};
	
=item $cstoolbasepage-E<gt>}click_arinvoice_tab()

Click arinvoice tab

=cut

sub click_arinvoice_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_ARINVOICE);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

=item $cstoolbasepage-E<gt>}click_rewardcard_tab()

Click rewardcard tab

=cut

sub click_rewardcard_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_REWARDCARD);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};		
	
=item $cstoolbasepage-E<gt>}click_landmark_tab()

Click landmark tab

=cut

sub click_landmark_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_LANDMARK);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};		
	
=item $cstoolbasepage-E<gt>}click_company_tab()

Click company tab

=cut

sub click_company_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_COMPANY);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};			
	
=item $cstoolbasepage-E<gt>}click_promo_tab()

Click promo tab

=cut

sub click_promo_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_PROMO);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};		

=item $cstoolbasepage-E<gt>}click_campaign_tab()

Click campaign tab

=cut

sub click_campaign_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_CAMPAIGN);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};	

=item $cstoolbasepage-E<gt>}click_source_tab()

Click source tab

=cut

sub click_source_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_SOURCE);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};		

=item $cstoolbasepage-E<gt>}click_state_tab()

Click state tab

=cut

sub click_state_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_STATE);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};		

=item $cstoolbasepage-E<gt>}click_market_tab()

Click market tab

=cut

sub click_market_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_MARKET);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};		

=item $cstoolbasepage-E<gt>}click_submarket_tab()

Click submarket tab

=cut

sub click_submarket_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_SUBMARKET);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};		

=item $cstoolbasepage-E<gt>}click_area_tab()

Click submarket tab

=cut

sub click_area_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_AREA);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};			

=item $cstoolbasepage-E<gt>}click_newcontent_tab()

Click newcontent tab

=cut

sub click_newcontent_tab {
	my ( $self ) = @_;
	
	$self->click(LINK_NEWCONTENT);
	$self->wait_for_page_to_load($self->get_page_timeout()); 
};

1;

}
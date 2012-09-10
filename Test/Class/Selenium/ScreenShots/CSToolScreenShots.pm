package Test::Class::Selenium::ScreenShots::CSToolScreenShots;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::CSTool::PropertyPage;
use Test::Class::Selenium::PageObjects::CSTool::NewContentPage;
use Test::Class::Selenium::DataAccessObjects::NewContentDao;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

CSToolScreenShots - Take screen shots related to insider

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 insider_tabs

Steps:

=over

=item  1. Visit the following pages:

    * property
    * contract
    * person
    * lease
    * arinvoice
    * rewardcard
    * landmark
    * company
    * promo
    * campaign
    * source
    * state
    * market
    * submarket
    * area
    * newcontent

=back

=cut

sub insider_tabs:Test(no_plan)
{
	my($self) = @_;
	
	my $property_id = "427068";
		
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{cs_username},$self->{cs_password});		

	#Tabs
	my $cstoolpropertypage = Test::Class::Selenium::PageObjects::CSTool::PropertyPage->new($self);
	$cstoolpropertypage->click_property_tab();
	$cstoolpropertypage->screen_capture("CSTool", "PropertyTab");	
	$cstoolpropertypage->click_contract_tab();
	$cstoolpropertypage->screen_capture("CSTool", "contract");	
	$cstoolpropertypage->click_person_tab();
	$cstoolpropertypage->screen_capture("CSTool", "person");	
	$cstoolpropertypage->click_lease_tab();
	$cstoolpropertypage->screen_capture("CSTool", "lease");	
	$cstoolpropertypage->click_arinvoice_tab();
	$cstoolpropertypage->screen_capture("CSTool", "arinvoice");	
	$cstoolpropertypage->click_rewardcard_tab();
	$cstoolpropertypage->screen_capture("CSTool", "rewardcard");	
	$cstoolpropertypage->click_landmark_tab();
	$cstoolpropertypage->screen_capture("CSTool", "landmark");	
	$cstoolpropertypage->click_company_tab();
	$cstoolpropertypage->screen_capture("CSTool", "company");	
	$cstoolpropertypage->click_promo_tab();
	$cstoolpropertypage->screen_capture("CSTool", "promo");	
	$cstoolpropertypage->click_campaign_tab(); 
	$cstoolpropertypage->screen_capture("CSTool", "campaign");	
	$cstoolpropertypage->click_source_tab();
	$cstoolpropertypage->screen_capture("CSTool", "source");	
	$cstoolpropertypage->click_state_tab();
	$cstoolpropertypage->screen_capture("CSTool", "state");	
	$cstoolpropertypage->click_market_tab();
	$cstoolpropertypage->screen_capture("CSTool", "market");	
	$cstoolpropertypage->click_submarket_tab();
	$cstoolpropertypage->screen_capture("CSTool", "submarket");	 
	$cstoolpropertypage->click_area_tab();
	$cstoolpropertypage->screen_capture("CSTool", "area");	
	$cstoolpropertypage->click_newcontent_tab(); 
	$cstoolpropertypage->screen_capture("CSTool", "newcontent");	
	
}

=head3 property_search

Steps:

=over

=item  1. Perform a property search

=back

=cut

sub property_search:Test(no_plan)
{
	my($self) = @_;

	my $property_id = "427068";
		
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{cs_username},$self->{cs_password});		

	#Tabs
	my $cstoolpropertypage = Test::Class::Selenium::PageObjects::CSTool::PropertyPage->new($self);
	
	#click on property tab
	$cstoolpropertypage->click_property_tab();
	#type property id
	$cstoolpropertypage->type_property_id($property_id);	
	#click on view properties
	$cstoolpropertypage->click_view_properties();
	$cstoolpropertypage->screen_capture("CSTool", "PDP");
	
}

=head3 review_new_content

Steps:

=over

=item  1. Review New Content

=back

=cut

sub review_new_content:Test(no_plan)
{
	my($self) = @_;
		
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{cs_username},$self->{cs_password});		
	
	#New Content
	my $newcontentdao = Test::Class::Selenium::DataAccessObjects::NewContentDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $cstool_newcontentpage = Test::Class::Selenium::PageObjects::CSTool::NewContentPage->new($self);    	
	#click on new content tab
	$cstool_newcontentpage->click_newcontent_tab();
	#type property id
	$cstool_newcontentpage->type_property_id($newcontentdao->get_most_recent_unapproved_img_for_a_plt_property());	
	#click go
	$cstool_newcontentpage->click_go();		
	$cstool_newcontentpage->screen_capture("CSTool", "NewContentReview");

}

1;

}
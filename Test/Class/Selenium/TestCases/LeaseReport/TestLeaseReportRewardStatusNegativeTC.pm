package Test::Class::Selenium::TestCases::LeaseReport::TestLeaseReportRewardStatusNegativeTC;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::PageObjects::SearchResultsPage;
use Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage;
use Test::Class::Selenium::PageObjects::LeaseAddressPage;
use Test::Class::Selenium::PageObjects::RewardStatusPage;
use Test::Class::Selenium::PageObjects::PropertyDescriptionPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Class::Selenium::DataAccessObjects::LeaseReportDao;
use Test::Most 'no_plan';
use base 'Test::Class::Selenium::TestCases::BaseTest';
use DateTime;
use Data::RandomPerson::Names::Last;
use Data::RandomPerson::Names::Female;


=head1 NAME

TestLeaseReport

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=back

=head2 

Verify Lease Report functionality

Test Steps:

Expected Result:


=cut

sub test_renter_completes_cpa_lease_report: Test(no_plan)
{
	my($self, $lname, $cosign_lname) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $lease_id;
	my $first_name = Data::RandomPerson::Names::Female->new();
	my $last_name = Data::RandomPerson::Names::Last->new();

	my $email = $data->create_email();
	
	# If $lname and $cosign_lname is empty, Perl will warn that the values are uninitialized.
	# For the purposes of testing, this warning is fine and can be ignored.
	print "# Last Name passed from potential dupe method = $lname\n";
	print "# Cosigner Last Name passed from potential dupe method = $cosign_lname\n";
	
	if ($lname eq "")
	{
		$lname = $last_name->get();
	}
	
	if ($cosign_lname eq "")
	{
		$cosign_lname = $last_name->get();
	}
	
	my $fname = $first_name->get();
	# my $lname = $last_name->get();
	my $cosign_fname = $first_name->get();
	# my $cosign_lname = $last_name->get();
	my $move_in_date = $data->get_todays_date_mmddyyyy();
	my $propertyid =  $leasereportdao->find_valid_lease_property_id();
	
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	print "\n#email:  ".$email."\n";
	print "# first name: ".$fname."\n";
	print "# last name: ".$lname."\n";
	print "# cosign first name: ".$cosign_fname."\n";
	print "# cosign last name: ".$cosign_lname."\n";
	$landingpage->view_the_latest_listings("Las Vegas", "NV", "\$100", "\$5000+", "Studio+", $email);		
	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	#click on CPA PROPERTY
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	$searchresultspage->submit_password();
	$searchresultspage->goto_property($propertyid);
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);

	SKIP:
	{
		skip('Because lease reports page needs to be looked into further for IE', 2) if($self->{browser_type} eq "*iexploreproxy" || $self->{browser_type} eq "*iexplore");
	 
		#click on claim reward
		$propertydescriptionpage->click_claim_reward();
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Your New Address"), 'Verify on lease report page');	
		# $leasereportpage->submit_lease_report($fname, $lname, $move_in_date);
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);
		$leasereportpage->submit_lease();
	
		#address page
		ok($leasereportpage->is_text_present("Your Reward Card will be mailed to:*"), 'Verify on address page');
		
		# check lease status
		my $page_url = $leasereportpage->get_location();
		my $url_length = length ($page_url);
		my $str_offset;
		
		# lease_id can come in one of two forms - check for these two forms before parsing the lease id
		if ( $page_url =~ m/lease_property_id/ )
		{
			$str_offset = rindex($page_url, "lease_property_id") + length ("lease_property_id") + 1;
		}
		
		if ( $page_url =~ m/lease_id/ )
		{
			$str_offset = rindex($page_url, "lease_id") + length ("lease_id") + 1;
		}
		
		$lease_id = substr( $page_url, $str_offset );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		print ("# Lease Status = $lease_status\n");
		
		$leasereportpage->pause("5000");
		$leasereportpage->sign_out();
	}
	
	return ($lname, $cosign_lname, $lease_id, $email);
}

sub test_reward_status_page_display_incomplete_lease_status() : Test(no_plan)
{
	my ( $self ) = @_;
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	my ( $fname, $lname, $lease_id, $email ) = $self->test_renter_completes_cpa_lease_report("","");
	
	# print "First name, Last Name, Lease ID = $fname, $lname, $lease_id\n";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->login_as($email, $self->{password});		
	ok($loginpage->is_text_present("Welcome"), 'Verify user '.$email.' is logged in');
	
	# Verify Reward Status page does not display if lease status is 'Incomplete' or 'Invalid-IWRR'
	my $lease_status = $leasereportdao->check_lease_status( $lease_id );
	print "# Lease status before modification = $lease_status\n";
	
	$leasereportdao->modify_lease_status( $lease_id, "Incomplete");
	
	my $lease_status_mod = $leasereportdao->check_lease_status( $lease_id );
	print "# Lease status after modification = $lease_status_mod\n";
	
	$loginpage->click("link=\$100 Reward Card");
	my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
	
	$leasereportpage->pause( "5000" );
	
	# Verify Reward Status page is NOT displayed - Property Selection page should be displayed instead
	ok($leasereportpage->is_text_present("Leased at a property featuring our \$100 Reward Card?"), 'Verify on Property Selection page');
	
	$leasereportpage->sign_out();	

}

#sub test_reward_status_page_display_returned_reward_card_61_days() : Test()
#{
#	my ( $self ) = @_;
#	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
#	
#	# ===== IN LIEU OF CREATING A LEASE REPORT PRIOR TO FINDING A RETURNED REWARD CARD,
#	# ===== QUERY THE DB TO FIND A RECENTLY RETURNED REWARD CARD
##	my ( $fname, $lname, $lease_id, $email ) = $self->test_renter_completes_cpa_lease_report("","");
##	
##	# print "First name, Last Name, Lease ID = $fname, $lname, $lease_id\n";
##	
##	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
##	$loginpage->login_as($email, $self->{password});		
##	ok($loginpage->is_text_present("Welcome"), 'Verify user '.$email.' is logged in');
##	
##	# Returned RC:  Verify Reward Status page is displayed for 60 days after return date of last-issued reward
##	my $lease_status = $leasereportdao->check_lease_status( $lease_id );
##	print "# Lease status = $lease_status\n";
#	
#	my $lease_id_returned_card = $leasereportdao->find_returned_reward_card();
#	print "# Lease ID of Returned Reward Card = $lease_id_returned_card\n";
#	my $rc_status = $leasereportdao->check_reward_card_status( $lease_id_returned_card );
#	ok(($rc_status eq "Canceled"), 'Verify Reward Card Status is equal to Canceled');
#	my $rc_return_date = $leasereportdao->check_reward_card_return_date( $lease_id_returned_card );
#	ok(($rc_return_date ne ""), 'Verify Reward Card Return Date is not null');
#	
#	# Verify reward status page is not displayed if current date is 61 or more days after
#	# return date of last-issued reward card
#	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
#	my $return_dt = $dt->subtract( days => 61 );
#	my $return_dt_month = $dt->month_abbr();
#	my $return_dt_day = $dt->day();
#	my $return_dt_year = $dt->year();
#	my $new_return_dt = "$return_dt_day-$return_dt_month-$return_dt_year";
#	print "# New Return Date = $new_return_dt\n";
#	
#	$leasereportdao->modify_reward_card_return_date( $lease_id_returned_card, $new_return_dt );
#	$rc_return_date = $leasereportdao->check_reward_card_return_date( $lease_id_returned_card );
#	print "# New RC Return Date = $rc_return_date\n";
#	
#	my $email = $leasereportdao->get_reward_card_email_nm( $lease_id_returned_card );
#	print "# Email = $email\n";
#	
#	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
#	$loginpage->login_as($email, $self->{password});
#	ok($loginpage->is_text_present("Welcome"), 'Verify user '.$email.' is logged in');
#	$loginpage->click("link=\$100 Reward Card");
#	my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
#	
#	# Verify Reward Status page is NOT displayed - Property Selection page should be displayed instead
#	ok($leasereportpage->is_text_present("Leased at a property featuring our \$100 Reward Card?"), 'Verify on Property Selection page');
#	
#	$leasereportpage->pause( "5000" );
#	$leasereportpage->sign_out();
#}

sub test_reward_status_page_display_returned_reward_card_60_days() : Test(no_plan)
{
	my ( $self ) = @_;
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	# ===== IN LIEU OF CREATING A LEASE REPORT PRIOR TO FINDING A RETURNED REWARD CARD,
	# ===== QUERY THE DB TO FIND A RECENTLY RETURNED REWARD CARD
#	my ( $fname, $lname, $lease_id, $email ) = $self->test_renter_completes_cpa_lease_report("","");
#	
#	# print "First name, Last Name, Lease ID = $fname, $lname, $lease_id\n";
#	
#	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
#	$loginpage->login_as($email, $self->{password});		
#	ok($loginpage->is_text_present("Welcome"), 'Verify user '.$email.' is logged in');
#	
#	# Returned RC:  Verify Reward Status page is displayed for 60 days after return date of last-issued reward
#	my $lease_status = $leasereportdao->check_lease_status( $lease_id );
#	print "# Lease status = $lease_status\n";
	
	my $lease_id_returned_card = $leasereportdao->find_returned_reward_card();
	print "# Lease ID of Returned Reward Card = $lease_id_returned_card\n";
	my $rc_status = $leasereportdao->check_reward_card_status( $lease_id_returned_card );
	ok(($rc_status eq "Canceled"), 'Verify Reward Card Status is equal to Canceled');
	my $rc_return_date = $leasereportdao->check_reward_card_return_date( $lease_id_returned_card );
	ok(($rc_return_date ne ""), 'Verify Reward Card Return Date is not null');
	
	# Verify reward status page is not displayed if current date is 61 or more days after
	# return date of last-issued reward card
	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $return_dt = $dt->subtract( days => 60 );
	my $return_dt_month = $dt->month_abbr();
	my $return_dt_day = $dt->day();
	my $return_dt_year = $dt->year();
	my $new_return_dt = "$return_dt_day-$return_dt_month-$return_dt_year";
	print "# New Return Date = $new_return_dt\n";
	
	$leasereportdao->modify_reward_card_return_date( $lease_id_returned_card, $new_return_dt );
	$rc_return_date = $leasereportdao->check_reward_card_return_date( $lease_id_returned_card );
	print "# New RC Return Date = $rc_return_date\n";
	
	my $email = $leasereportdao->get_reward_card_email_nm( $lease_id_returned_card );
	print "# Email = $email\n";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->login_as($email, $self->{password});
	
	$loginpage->pause( "5000" );
	ok($loginpage->is_text_present("Welcome"), 'Verify user '.$email.' is logged in');
	$loginpage->click("link=\$100 Reward Card");
	
	my $rewardstatuspage = Test::Class::Selenium::PageObjects::RewardStatusPage->new($self);
	# Verify Reward Status page is displayed
	ok($rewardstatuspage->is_text_present("Reward Card Mailing Address"), 'Verify on Reward Status page');
	
	$rewardstatuspage->pause( "5000" );
	$rewardstatuspage->sign_out();
}

sub test_reward_status_page_display_canceled_reward_card() : Test(no_plan)
{
	my ( $self ) = @_;
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	my ( $fname, $lname, $lease_id, $email ) = $self->test_renter_completes_cpa_lease_report("","");
	
	# print "First name, Last Name, Lease ID = $fname, $lname, $lease_id\n";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->login_as($email, $self->{password});		
	ok($loginpage->is_text_present("Welcome"), 'Verify user '.$email.' is logged in');
	
	# Canceled RC:  Verify Reward Status page is displayed for 60 days after the cancel date of the reward card
	my $lease_status = $leasereportdao->check_lease_status( $lease_id );
	print "# Lease status = $lease_status\n";
	
	$lease_id = '5799497';
	$leasereportdao->check_reward_card_status( $lease_id );
	$leasereportdao->check_reward_card_return_date( $lease_id );
	$leasereportdao->check_reward_card_cancel_date( $lease_id );
	
	$loginpage->click("link=\$100 Reward Card");
	my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
	
	$leasereportpage->pause( "5000" );
	
	# Canceled RC:  Verify Reward Status page is displayed for 60 days after the cancel date of the reward card
	
}

sub test_reward_status_page_display_reissued_reward_card() : Test(no_plan)
{
	my ( $self ) = @_;
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	my ( $fname, $lname, $lease_id, $email ) = $self->test_renter_completes_cpa_lease_report("","");
	
	# print "First name, Last Name, Lease ID = $fname, $lname, $lease_id\n";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->login_as($email, $self->{password});		
	ok($loginpage->is_text_present("Welcome"), 'Verify user '.$email.' is logged in');
	
	# Re-issued RC:  Verify Reward Status page is displayed for 60 days after the last-issued reward card
	my $lease_status = $leasereportdao->check_lease_status( $lease_id );
	print "# Lease status = $lease_status\n";
	
	$lease_id = '5799497';
	$leasereportdao->check_reward_card_status( $lease_id );
	$leasereportdao->check_reward_card_return_date( $lease_id );
	$leasereportdao->check_reward_card_cancel_date( $lease_id );
	
	$loginpage->click("link=\$100 Reward Card");
	my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
	
	$leasereportpage->pause( "5000" );
	
	# Re-issued RC:  Verify Reward Status page is displayed for 60 days after the last-issued reward card	
}

1;

}

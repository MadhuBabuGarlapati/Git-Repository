package Test::Class::Selenium::TestCases::LeaseReport::TestLeaseReportRefactored;

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
use Test::Class::Selenium::DataAccessObjects::PickDao;
use Test::Most qw(no_plan);
use base 'Test::Class::Selenium::TestCases::BaseTest';
use DateTime;
use Data::RandomPerson::Names::Last;
use Data::RandomPerson::Names::Female;
use String::Random;


=head1 NAME

TestLeaseReport

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 generate_lease_data

Utility function to generate Lease data, such as renter and cosigner names

=cut
sub generate_lease_data
{
	my ( $self ) = @_;
	
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $first_name = Data::RandomPerson::Names::Female->new();
	my $last_name = Data::RandomPerson::Names::Last->new();
	
	my $fname = $first_name->get();
	my $lname = $last_name->get();
	my $cosigner_fname = $first_name->get();
	my $cosigner_lname = $last_name->get();
	
	# =====================================================================
	# ===== USE THESE CODE PORTIONS IF LEASE REPORT TEST CONSISTENTLY =====
	# ===== REPORT FAILURES IN NOT MATCHING LEASE STATUSES            =====
	# =====================================================================
	# Generate unique renter name to prevent lease from being placed 
	# in 'Researching' status for potential duplicate leases
	# while ( $leasereportdao->get_num_dupe_cosigner_names( $lname ) != 0 )
	# {
	# 	my $last_name = Data::RandomPerson::Names::Last->new();
	# 	$lname = $last_name->get();
	# }
	
	# Generate unique rcosigner last name to prevent lease from being placed 
	# in 'Researching' status for potential duplicate leases
	# while ( $leasereportdao->get_num_dupe_renter_last_names( $cosigner_lname ) != 0 )
	# {
	# 	my $last_name = Data::RandomPerson::Names::Last->new();
	# 	$cosigner_lname = $last_name->get();
	# }
	# =====================================================================
	
	# Comment this section post-debugging
	print "# first name: ".$fname."\n";
	print "# last name: ".$lname."\n";
	print "# cosigner first name: ".$cosigner_fname."\n";
	print "# cosigner last name: ".$cosigner_lname."\n";
	
	return ( $fname, $lname, $cosigner_fname, $cosigner_lname );
}

=head3 test_renter_completes_cpa_lease_report

Verify Lease Report functionality - Submit a successful Lease Report

Test Steps:

=over

=item 1. Go to landing page.

=item 2. Click on a CPA property.

=item 3. Click Claim Reward link.

=item 4. Fill out name fields on Lease Report Submission form.

=item 5. Specify today's date as the MID.

=item 6. Submit Lease Report.

=item 7. Save default Move-In address.

=back

Expected Result:

Renter is redirected to the Reward Status page.

=cut

sub test_renter_completes_cpa_lease_report: Test(no_plan)
{
	my( $self ) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $lease_id;
	my $email = $data->create_email();
	my ( $fname, $lname, $cosign_fname, $cosign_lname ) = $self->generate_lease_data();	
	my $move_in_date = $data->get_todays_date_mmddyyyy();
	my $propertyid =  $leasereportdao->get_valid_lease_property_id();
	
	print "\n#email:  ".$email."\n";
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);

	$landingpage->view_the_latest_listings("Las Vegas", "NV", "\$100", "\$5000+", "Studio+", $email);		
	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	#click on CPA PROPERTY
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	# convert Optional Password Pick B renters to Pick A to force display of Password interstitial
	if ( $propertydescriptionpage->is_text_present("Create Password") )
	{
		$pickdao->password_set_pick_A($email);
	}
	else
	{
		$propertydescriptionpage->submit_password();	
	}
	
	$propertydescriptionpage->goto_property($propertyid);

	SKIP:
	{
		skip('Because lease reports page needs to be looked into further for IE', 2) if($self->{browser_type} eq "*iexploreproxy" || $self->{browser_type} eq "*iexplore");
	 
		#click on claim reward
		$propertydescriptionpage->click_claim_reward();
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Ready to Claim"), 'Verify on lease report page');	
		# $leasereportpage->submit_lease_report($fname, $lname, $move_in_date);
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);
		$leasereportpage->submit_lease();
	
		# now on address page
		ok($leasereportpage->is_text_present("Your Reward Card will be mailed to:*"), 'Verify on address page');
		my $leaseaddresspage = Test::Class::Selenium::PageObjects::LeaseAddressPage->new( $self );
		
		# check lease status
		my $page_url = $leasereportpage->get_location();
		my $url_length = length ($page_url);
		my $str_offset = rindex($page_url, "lease_id") + length ("lease_id") + 1;
		$lease_id = substr( $page_url, $str_offset );
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		print ("# Lease Status = $lease_status\n");
		
		$leaseaddresspage->save_address();
		
		# now on reward status page
		my $rewardstatuspage = Test::Class::Selenium::PageObjects::RewardStatusPage->new($self);
		my $reward_status_page_text = $rewardstatuspage->get_page_text();
		# print "# Reward Status Page Text = $reward_status_page_text\n";
		ok($reward_status_page_text =~ m/Reward Card Mailing Address/i, 'Verify on Reward Card Status page');
		
		$leasereportpage->pause("5000");
		$leasereportpage->sign_out();
	}
}


=head3 test_lease_report_submission_with_early_lease_date

Verify Lease Report functionality - Lease Report Submission with Early Lease Date

Test Steps:

=over

=item 1. Go to landing page.

=item 2. Click on a CPA property.

=item 3. Click Claim Reward link.

=item 4. Fill out name fields on Lease Report Submission form.

=item 5. Specify an early MID (greater than 100 days in the future)

=back

Expected Result:

=over

=item 1. Renter is warned of early lease date.

=item 2. Renter is able to submit lease; system sets lease status to "Early Lease Report". 

=back

=cut

sub test_lease_report_submission_with_early_lease_date: Test(no_plan)
{
	my( $self ) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $email = $data->create_email();
	my ( $fname, $lname, $cosign_fname, $cosign_lname ) = $self->generate_lease_data();
	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $early_lease_dt = $dt->add( days => 101 );
	my $move_in_date= $early_lease_dt->mdy('/');
	my $propertyid =  $leasereportdao->get_valid_lease_property_id();
	
	print ("# Move in date is $move_in_date\n");
	print "\n#email:  ".$email."\n";
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	$landingpage->view_the_latest_listings("Las Vegas", "NV", "\$100", "\$5000+", "Studio+", $email);		
	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	#click on CPA PROPERTY
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	# convert Optional Password Pick B renters to Pick A to force display of Password interstitial
	if ( $propertydescriptionpage->is_text_present("Create Password") )
	{
		$pickdao->password_set_pick_A($email);
	}
	else
	{
		$propertydescriptionpage->submit_password();	
	}
	
	$propertydescriptionpage->goto_property($propertyid);

	SKIP:
	{
		skip('Because lease reports page needs to be looked into further for IE', 2) if($self->{browser_type} eq "*iexploreproxy" || $self->{browser_type} eq "*iexplore");
	
		#click on claim reward
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Ready to Claim"), 'Verify on lease report page');	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);		
		
		# Verify warning is displayed for an early move-in date
		ok($leasereportpage->is_text_present("You entered a date that is significantly in the future"), 'Verify early move-in date');
		
		# submit early lease
		$leasereportpage->submit_lease();
		ok($leasereportpage->is_text_present("Your Reward Card will be mailed to:*"), 'Verify on address page');
				
		# validate lease status (DB)
		my $page_url = $leasereportpage->get_location();
		my $url_length = length ($page_url);
		my $str_offset = rindex($page_url, "lease_id") + length ("lease_id") + 1;
		my $lease_id = substr( $page_url, $str_offset );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		print ("# Lease Status = $lease_status\n");
		ok( $lease_status eq "Early Lease Report", 'Verify lease status set to "Early Lease Report"' );
	}
}

=head3 test_lease_report_submission_with_early_lease_date_pre_confirming

Verify Lease Report functionality - Lease Report Submission with Early Lease Date (Pre-Confirming)

Test Steps:

=over

=item 1. Go to landing page.

=item 2. Click on a CPA property.

=item 3. Click Claim Reward link.

=item 4. Fill out name fields on Lease Report Submission form.

=item 5. Specify an early MID (between 2 and 100 days in the future)

=back

Expected Result:
Renter is able to submit lease; system sets lease status to "Pre-Confirming". 

=cut

sub test_lease_report_submission_with_early_lease_date_pre_confirming: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $email = $data->create_email();
	my ( $fname, $lname, $cosign_fname, $cosign_lname ) = $self->generate_lease_data();
	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $early_lease_dt = $dt->add( days => 100 );
	my $move_in_date= $early_lease_dt->mdy('/');
	my $propertyid =  $leasereportdao->get_valid_lease_property_id();
	
	print ("# Move in date is $move_in_date\n");
	print "\n#email:  ".$email."\n";
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	$landingpage->view_the_latest_listings("Las Vegas", "NV", "\$100", "\$5000+", "Studio+", $email);		
	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	#click on CPA PROPERTY
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	# convert Optional Password Pick B renters to Pick A to force display of Password interstitial
	if ( $propertydescriptionpage->is_text_present("Create Password") )
	{
		$pickdao->password_set_pick_A($email);
	}
	else
	{
		$propertydescriptionpage->submit_password();	
	}
	
	$propertydescriptionpage->goto_property($propertyid);

	SKIP:
	{
		skip('Because lease reports page needs to be looked into further for IE', 2) if($self->{browser_type} eq "*iexploreproxy" || $self->{browser_type} eq "*iexplore");
	
		#click on claim reward
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Ready to Claim"), 'Verify on lease report page');	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);
		
		# Verify warning is displayed for an early move-in date
		# No need to check for this warning for verifying Pre-Confirming status
		# ok($leasereportpage->is_text_present("You entered a date that is significantly in the future"), 'Verify early move-in date');
		
		# submit early lease
		$leasereportpage->submit_lease();
				
		# validate lease status (DB)
		my $page_url = $leasereportpage->get_location();
		my $url_length = length ($page_url);
		my $str_offset = rindex($page_url, "lease_id") + length ("lease_id") + 1;
		my $lease_id = substr( $page_url, $str_offset );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		print ("# Lease Status = $lease_status\n");	
		ok( $lease_status eq "Pre-Confirming", 'Verify lease status set to "Pre-Confirming"' );

		# return ($leasereportpage);
	}
}


=head3 test_lease_report_submission_with_late_lease_date

Verify Lease Report functionality - Lease Report Submission with Late Lease Date

Test Steps:

=over

=item 1. Go to landing page.

=item 2. Click on a CPA property.

=item 3. Click Claim Reward link.

=item 4. Fill out name fields on Lease Report Submission form.

=item 5. Specify a late MID (-91 days or greater in the past).

=back

Expected Result:

=over 

=item 1. Renter is warned of late lease date.

=item 2. Renter is able to submit lease; system sets lease status to "Invalid - Late". 

=back

=cut

sub test_lease_report_submission_with_late_lease_date: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $email = $data->create_email();
	my ( $fname, $lname, $cosign_fname, $cosign_lname ) = $self->generate_lease_data();
	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $early_lease_dt = $dt->subtract( days => 91 );
	my $move_in_date= $early_lease_dt->mdy('/');
	my $propertyid =  $leasereportdao->get_valid_lease_property_id();
	
	print ("Move in date is $move_in_date\n");
	print "\n#email:  ".$email."\n";
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	
	$landingpage->view_the_latest_listings("Las Vegas", "NV", "\$100", "\$5000+", "Studio+", $email);		
	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	#click on CPA PROPERTY
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	# convert Optional Password Pick B renters to Pick A to force display of Password interstitial
	if ( $propertydescriptionpage->is_text_present("Create Password") )
	{
		$pickdao->password_set_pick_A($email);
	}
	else
	{
		$propertydescriptionpage->submit_password();	
	}
	
	$propertydescriptionpage->goto_property($propertyid);

	SKIP:
	{
		skip('Because lease reports page needs to be looked into further for IE', 2) if($self->{browser_type} eq "*iexploreproxy" || $self->{browser_type} eq "*iexplore");
	
		#click on claim reward
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Ready to Claim"), 'Verify on lease report page');	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);		
		
		# Verify warning is displayed for an late lease date
		ok($leasereportpage->wait_for_text_present("You entered a date that is significantly in the past"), 'Verify late lease date');
		
		# submit late lease - need to verify landing page post-submission AFTER reward card status page dev is complete
		$leasereportpage->submit_lease();
		# ok($leasereportpage->is_text_present("Your Reward Card will be mailed to:*"), 'Verify on address page');
				
		# validate lease status (DB)
		my $page_url = $leasereportpage->get_location();
		my $url_length = length ($page_url);
		my $str_offset = rindex($page_url, "lease_id") + length ("lease_id") + 1;
		my $lease_id = substr( $page_url, $str_offset );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		print ("# Lease Status = $lease_status\n");
		ok( $lease_status eq "Invalid - Late", 'Verify lease status set to "Invalid - Late"' );
	}
}

=head3 test_lease_report_submission_with_late_lease_date_confirming

Verify Lease Report functionality - Lease Report Submission with Late Lease Date (Confirming)

Test Steps:

=over

=item 1. Go to landing page.

=item 2. Click on a CPA property.

=item 3. Click Claim Reward link.

=item 4. Fill out name fields on Lease Report Submission form.

=item 5. Specify a late MID (between -90 days in the past and +2 days in the future)

=back

Expected Result:

Renter is able to submit lease; system sets lease status to "Confirming". 

=cut

sub test_lease_report_submission_with_late_lease_date_confirming: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $email = $data->create_email();
	my ( $fname, $lname, $cosign_fname, $cosign_lname ) = $self->generate_lease_data();
	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $early_lease_dt = $dt->subtract( days => 90 );
	my $move_in_date= $early_lease_dt->mdy('/');
	my $propertyid =  $leasereportdao->get_valid_lease_property_id();
	
	print ("# Move in date is $move_in_date\n");
	print "\n#email:  ".$email."\n";

	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);

	$landingpage->view_the_latest_listings("Las Vegas", "NV", "\$100", "\$5000+", "Studio+", $email);		
	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	#click on CPA PROPERTY
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	# convert Optional Password Pick B renters to Pick A to force display of Password interstitial
	if ( $propertydescriptionpage->is_text_present("Create Password") )
	{
		$pickdao->password_set_pick_A($email);
	}
	else
	{
		$propertydescriptionpage->submit_password();	
	}
	
	$propertydescriptionpage->goto_property($propertyid);

	SKIP:
	{
		skip('Because lease reports page needs to be looked into further for IE', 2) if($self->{browser_type} eq "*iexploreproxy" || $self->{browser_type} eq "*iexplore");
	
		#click on claim reward
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Ready to Claim"), 'Verify on lease report page');	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);		
	
		# Verify warning is displayed for an late lease date
		# No need to check for this warning for verifying Confirming status
		# ok($leasereportpage->is_text_present("You entered a date that is significantly in the past"), 'Verify late lease date');
		
		# submit late lease - need to verify landing page post-submission AFTER reward card status page dev is complete
		$leasereportpage->submit_lease();	
						
		# validate lease status (DB)
		my $page_url = $leasereportpage->get_location();
		my $url_length = length ($page_url);
		my $str_offset = rindex($page_url, "lease_id") + length ("lease_id") + 1;
		my $lease_id = substr( $page_url, $str_offset );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		print ("# Lease Status = $lease_status\n");
		ok( $lease_status eq "Confirming", 'Verify lease status set to "Confirming"' );	
	}
}


=head3 test_reward_card_to_move_in_address_switching

Verify Lease Report functionality - Lease Report Submission with Late Lease Date (Confirming)

Test Steps:

=over

=item 1. Go to landing page.

=item 2. Click on a CPA property.

=item 3. Click Claim Reward link.

=item 4. Fill out name fields on Lease Report Submission form.

=item 5. Specify any MID.

=item 6. Repeatedly switch between move-in address and reward card mailing address.

=item 7. Before hitting the Submit button, ensure move-in address is specified.

=back

Expected Result:

Reward Card Mailing address is the move-in address (specified in the Address page).

=cut	
sub test_reward_card_to_move_in_address_switching: Test(no_plan)
{
	my ( $self ) = @_;
	
	# Test submission of an early lease report:
	# Appropriate messaging should be shown on LR Submission & Address pages
	print "# LR Address page - testing submission of EARLY lease report.\n";
	$self->test_lease_report_submission_with_early_lease_date_pre_confirming();
	
	my $leaseaddresspage = Test::Class::Selenium::PageObjects::LeaseAddressPage->new($self);
	ok($leaseaddresspage->is_text_present("Your Reward Card will be mailed to:*"), 'Verify on address page');
		
	my $page_text = $leaseaddresspage->get_page_text();
	ok($page_text =~ m/Confirming the address you are moving to will help/i, 'Verify MID message for EARLY lease is displayed');
	
	$leaseaddresspage->specify_reward_card_address("123 Main St","N","Santa Monica","CA","90404", "3104498877");
	$leaseaddresspage->specify_move_in_address();
	# $leaseaddresspage->click("lease_unitaddress_nm");early_MID_reward_card_address
	my $move_in_address = $leaseaddresspage->get_text_value("lease_unitaddress_nm");
	print "# Move In Address = $move_in_address\n";
	$leaseaddresspage->save_address();
	
	$leaseaddresspage->pause("5000");

	my $rewardstatuspage = Test::Class::Selenium::PageObjects::RewardStatusPage->new($self);
	my $reward_status_page_text = $rewardstatuspage->get_page_text();
	# print "# Reward Status Page Text = $reward_status_page_text\n";
	ok($reward_status_page_text =~ m/Reward Card Mailing Address/i, 'Verify on Reward Card Status page');
	ok($reward_status_page_text =~ m/$move_in_address/i, 'Verify Reward Card Mailing Address is '.$move_in_address);
}

=head3 test_reward_status_messaging_section 

# ----------------------------- SCENARIO -----------------------------------

# Verify Reward Status messaging section

# EXPECTED RESULT(S):

# - Display "Updated as of [yeterday's date]" and lease id at the bottom

# - Display correct message depending on lease status and/or rc card status

# - Highlight following call-to-action messages with an exclamation icon

# ---> and all red text when lease or reward card is in these statuses:

# ---> - Early Lease Report

# ---> - Researching-Lease Data Required

# ---> - Reward Card = Canceled

# ---> - Reward Card = Returned

# --------------------------------------------------------------------------

=cut
sub test_reward_status_messaging_section(): Test(no_plan)
{
	my ( $self ) = @_;
	
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	my @status = ('Incomplete',
		'Pre-Confirming', 
		'Confirming', 
		'Valid', 
		'Researching', 
		'Researching - Lease Data Required',
		'Early',
		'Invalid - Duplicate',
		'Invalid - Guestcard Issue',
		'Invalid - Renter Canceled / Never Moved In',
		'Invalid - Previous Tenant / Employee / Transfer / Roommate',
		'Invalid - Management Company',
		'Invalid - Not a Rent.com Property',
		'Invalid - Inactive Property',
		'Invalid - Bogus',
		'Invalid - Renter Retracted',
		'Invalid - Late',
		'Invalid - Repursue',
		'Invalid - Lease Data Failed - Referral Source',
		'Invalid - Lease Data Failed - Never Moved In',
		'Property Contact Failed');
	my $num_statuses = scalar(@status);	
	my $idx = 0;
	
	while ($idx < $num_statuses )
	{
		print "\n## Current array index = ".$idx."\n";
		print "## Status at array index = ".$status[$idx]."\n";
		my ( $person_email, $lease_id, $person_password ) = $leasereportdao->get_person_email_and_lease_id($status[$idx]);
		
		# Check if $person_email is set; if not set, there is no 
		# lease report in the DB for the lease status being tested
		if ( $person_email )
		{
			my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
			$loginpage->sign_in($person_email, $person_password);		
			ok($loginpage->wait_for_text_present("Sign Out", '30000'), 'Verify user '.$person_email.' is logged in');
			
			$loginpage->click("link=\$100 Reward Card");
			my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage->new($self);
			
			$leasereportpage->pause( "5000" );
			
			my $rewardstatuspage = Test::Class::Selenium::PageObjects::RewardStatusPage->new($self);
			my $lease_status = $status[$idx];
			my $page_text = $rewardstatuspage->get_page_text();
			
			my $dt = $leasereportdao->get_move_in_date( $lease_id );
			my $day_offset = 2;
			my $mo_offset = 3;
			my $year_offset = 4;
			my $move_in_day = substr($dt, 0, $day_offset);
			my $move_in_mo = substr($dt, 3, $mo_offset);
			my $move_in_year = "20".substr($dt, 7, $year_offset);
		
			my %month_names = ("JAN" => "January",
				"FEB" => "February",
				"MAR" => "March",
				"APR" => "April",
				"MAY" => "May",
				"JUN" => "June",
				"JUL" => "July",
				"AUG" => "August",
				"SEP" => "September",
				"OCT" => "October",
				"NOV" => "November",
				"DEC" => "December");
			
			my $move_in_month = $month_names{$move_in_mo};
		
			my $move_in_date = $move_in_month.' '.$move_in_day.', '.$move_in_year;
			my $property_name = $leasereportdao->get_lease_property_name ( $lease_id );
			my $reward_status_msg = $rewardstatuspage->get_reward_status_message( $lease_status, $move_in_date, $property_name );

			if ( $reward_status_msg )
			{
				ok( $rewardstatuspage->is_text_present($reward_status_msg),'Verify messaging for '.$lease_status.' lease status.');
			}
			else
			{
				print "## Expected Reward Status Message not defined in RewardStatusPage hash. ##\n";
			}
			
			$rewardstatuspage->pause("5000");
			$rewardstatuspage->sign_out();
		}
		else
		{
			print "\n## Lease Report with status of ".$status[$idx]." does not exist in the DB. ##\n";
		}
		$idx++;
	}
}

=head2 

Verify Lease Report functionality - Lease Warning filter

Test Steps:
1. Go to landing page.
2. Click on a CPA property.
3. Click Claim Reward link.
4. Fill out name fields on Lease Report Submission form.*
* Names is randomly generated, and may meet one or more of the following criteria:
- Consecutive (3 or more) dashes, consonants, or vowels (i.e. aeiou or aaaaa)
5. Specify today's date as the MID.

Expected Result:
Renter is able to submit the lease; system sets status to "Researching"

=cut

sub test_lease_warning_filter(): Test(no_plan)
{
	my($self, $fname, $lname) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $pickdao = Test::Class::Selenium::DataAccessObjects::PickDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $email = $data->create_email();
	# my $fname = $data->create_alpha_string(10);
	# my $lname = $data->create_alpha_string(10);
	my $cosign_fname = '';
	my $cosign_lname = '';
	my $move_in_date = $data->get_todays_date_mmddyyyy();
	my $propertyid =  $leasereportdao->get_valid_lease_property_id();
	
	
	if (!$fname)
	{
		my $str = new String::Random;
	
		$fname = ($str->randregex("[J][a]{3}[a-z]{3}[aeiou]{3}[k]"));
	}
	
	if (!$lname)
	{
		my $str = new String::Random;
	
		$lname = ($str->randregex("[D][a-e]{3}[a-z]{3}[a-z]{3}[e]"));
	}
	
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	print "\n#email:  ".$email."\n";
	print "#first name: ".$fname."\n";
	print "#last name: ".$lname."\n";
	$landingpage->view_the_latest_listings("Las Vegas", "NV", "\$100", "\$5000+", "Studio+", $email);		
	ok($landingpage->is_page_title_present("Rent.com: Search Results"), 'Verify you are brought to Search page after signup');

	my $searchresultspage = Test::Class::Selenium::PageObjects::SearchResultsPage->new($self);
	
	#click on CPA PROPERTY
	ok($searchresultspage->click_on_first_property_more_info_button(), 'Verify that there are search results');
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);
	# convert Optional Password Pick B renters to Pick A to force display of Password interstitial
	if ( $propertydescriptionpage->is_text_present("Create Password") )
	{
		$pickdao->password_set_pick_A($email);
	}
	else
	{
		$propertydescriptionpage->submit_password();	
	}
	
	$propertydescriptionpage->goto_property($propertyid);

	SKIP:
	{
		skip('Because lease reports page needs to be looked into further for IE', 2) if($self->{browser_type} eq "*iexploreproxy" || $self->{browser_type} eq "*iexplore");
	
		#click on claim reward
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportRefactor::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Ready to Claim"), 'Verify on lease report page');	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);

		$leasereportpage->submit_lease();	
		
		$leasereportpage->pause("20000");
			
		# validate lease status (DB)		
		my $page_url = $leasereportpage->get_location();
		my $url_length = length ($page_url);
		my $str_offset = rindex($page_url, "lease_id") + length ("lease_id") + 1;
		my $lease_id = substr( $page_url, $str_offset );
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		print ("# Lease Status = $lease_status\n");
		
		ok( $lease_status eq "Researching", 'Verify lease status set to "Researching"' );
		
		return ($leasereportpage);
	}
}

1;

}

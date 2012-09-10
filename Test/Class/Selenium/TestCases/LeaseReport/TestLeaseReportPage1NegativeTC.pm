package Test::Class::Selenium::TestCases::LeaseReport::TestLeaseReportPage1NegativeTC;

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
		
		my $lease_id = substr( $page_url, $str_offset );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		print ("# Lease Status = $lease_status\n");
		
		$leasereportpage->pause("5000");
		$leasereportpage->sign_out();
	}
	
	return ($lname, $cosign_lname);
}


=head2 

Verify Lease Report functionality

Test Steps:

Expected Result:


=cut

sub test_renter_enters_invalid_first_and_last_name: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $email = $data->create_email();
	my $fname = "#";
	my $lname = "!";
	my $cosign_fname = '%';
	my $cosign_lname = '%';
	my $move_in_date = $data->get_todays_date_mmddyyyy();
	my $propertyid =  $leasereportdao->find_valid_lease_property_id();
	
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	print "\n#email:  ".$email."\n";
	print "#first name: ".$fname."\n";
	print "#last name: ".$lname."\n";
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
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
		ok($leasereportpage->is_text_present("Your New Address"), 'Verify on lease report page');
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);
		$leasereportpage->submit_lease();
		ok($leasereportpage->is_text_present("First Name: Please enter a valid first name"), 'Verify invalid firstname');
		ok($leasereportpage->is_text_present("Last Name: Please enter a valid last name"), 'Verify invalid lastname');
		ok($leasereportpage->is_text_present("Co-signer 1 First Name: Please enter a valid first name"), 'Verify invalid cosign first name');
		ok($leasereportpage->is_text_present("Co-signer 1 Last Name: Please enter a valid last name"), 'Verify invalid cosign last name');
	}
}

=head2 

Verify Lease Report functionality - Lease Report Submission with Invalid Date

Test Steps:
1. Go to landing page.
2. Click on a CPA property.
3. Click Claim Reward link.
4. Fill out name fields on Lease Report Submission form.
5. Enter an invalid date on MID field.

Expected Result:
Error message is displayed for an invalid move-in date

=cut

sub test_lease_report_submission_with_invalid_date: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $first_name = Data::RandomPerson::Names::Female->new();
	my $last_name = Data::RandomPerson::Names::Last->new();
	
	my $email = $data->create_email();
	my $fname = $first_name->get();
	my $lname = $last_name->get();
	my $cosign_fname = '%';
	my $cosign_lname = '%';
	my $move_in_date = '99999999';
	my $propertyid =  $leasereportdao->find_valid_lease_property_id();
	
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	print "\n#email:  ".$email."\n";
	print "#first name: ".$fname."\n";
	print "#last name: ".$lname."\n";
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
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
		ok($leasereportpage->is_text_present("Your New Address"), 'Verify on lease report page');
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);
		$leasereportpage->submit_lease();
		
		# Verify error message is displayed for an invalid move-in date
		ok($leasereportpage->is_text_present("Move-in Date: Please enter a valid date"), 'Verify invalid move-in date');
	}
}


=head2 

Verify Lease Report functionality - Lease Report Submission with Early Lease Date (Hard Error)

Test Steps:
1. Go to landing page.
2. Click on a CPA property.
3. Click Claim Reward link.
4. Fill out name fields on Lease Report Submission form.
5. Specify an early MID (greater than 365 days in the future)

Expected Result:
Renter stays on Lease Report Page 1 and is unable to submit the lease. 

=cut

sub test_lease_report_submission_with_early_lease_date_hard_error: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $first_name = Data::RandomPerson::Names::Female->new();
	my $last_name = Data::RandomPerson::Names::Last->new();
	
	my $email = $data->create_email();
	my $fname = $first_name->get();
	my $lname = $last_name->get();
	my $cosign_fname = $first_name->get();
	my $cosign_lname = $last_name->get();
	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $early_lease_dt = $dt->add( days => 368 );
	my $move_in_date= $early_lease_dt->mdy('/');
	my $propertyid =  $leasereportdao->find_valid_lease_property_id();
	
	print ("Move in date is $move_in_date\n");
	
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	print "\n#email:  ".$email."\n";
	print "#first name: ".$fname."\n";
	print "#last name: ".$lname."\n";
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
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Your New Address"), 'Verify on lease report page');	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);		
		
		# Verify warning is displayed for an early move-in date
		ok($leasereportpage->is_text_present("You entered a date that is significantly in the future"), 'Verify early move-in date');
		
		# submit early lease
		$leasereportpage->submit_lease();
		ok($leasereportpage->is_text_present("Move-in Date: Please enter a date that is within 365 days from today "), 'Verify still on LR page 1');
	}
}


=head2 

Verify Lease Report functionality - Lease Report Submission with Late Lease Date (Hard Error)

Test Steps:
1. Go to landing page.
2. Click on a CPA property.
3. Click Claim Reward link.
4. Fill out name fields on Lease Report Submission form.
5. Specify a late MID (greater than 365 days in the past)

Expected Result:
Renter stays on Lease Report Page 1 and is unable to submit the lease. 

=cut

sub test_lease_report_submission_with_late_lease_date_hard_error: Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $first_name = Data::RandomPerson::Names::Female->new();
	my $last_name = Data::RandomPerson::Names::Last->new();
	
	my $email = $data->create_email();
	my $fname = $first_name->get();
	my $lname = $last_name->get();
	my $cosign_fname = $first_name->get();
	my $cosign_lname = $last_name->get();
	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $early_lease_dt = $dt->subtract( days => 368 );
	my $move_in_date= $early_lease_dt->mdy('/');
	
	my $propertyid =  $leasereportdao->find_valid_lease_property_id();
	
	print ("# Move in date is $move_in_date\n");
	
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	print "\n#email:  ".$email."\n";
	print "#first name: ".$fname."\n";
	print "#last name: ".$lname."\n";
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
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Your New Address"), 'Verify on lease report page');	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);		
		
		# Verify warning is displayed for an late lease date
		ok($leasereportpage->is_text_present("You entered a date that is significantly in the past"), 'Verify late lease date');
		
		# submit late lease
		$leasereportpage->submit_lease();
		ok($leasereportpage->is_text_present("Move-in Date: Please enter a date that is within 365 days from today "), 'Verify still on LR page 1');
	}
	
}

=head2 

Verify Lease Report functionality - Profanity filter

Test Steps:
1. Go to landing page.
2. Click on a CPA property.
3. Click Claim Reward link.
4. Fill out name fields on Lease Report Submission form.  (Names must be selected from current list of profanity words.)
5. Specify today's date as the MID.

Expected Result:
Renter is able to submit the lease; system sets status to "Researching"

=cut

sub test_check_for_profanity_filter(): Test(no_plan)
{
	my($self) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $email = $data->create_email();
	my $fname = "twink";
	my $lname = "pron";
	my $cosign_fname = '';
	my $cosign_lname = '';
	my $move_in_date = $data->get_todays_date_mmddyyyy();
	my $propertyid =  $leasereportdao->find_valid_lease_property_id();
	
	
	my $landingpage = Test::Class::Selenium::PageObjects::LandingPage->new($self);
	print "\n#email:  ".$email."\n";
	print "#first name: ".$fname."\n";
	print "#last name: ".$lname."\n";
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
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Your New Address"), 'Verify on lease report page');	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);
		
		ok($leasereportpage->check_for_profanity_filter($fname),'Verify first name is checked for profanity');
		ok($leasereportpage->check_for_profanity_filter($lname), 'Verify last name is checked for profanity');
		
		$leasereportpage->submit_lease();
			
		# validate lease status (DB)		
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
		
		my $lease_id = substr( $page_url, $str_offset );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		ok( $lease_status eq "Researching", 'Verify lease status set to "Researching"' );
		print ("# Lease Status = $lease_status\n");
	}
}

=head2 

Verify Lease Report functionality - Potential Duplicate criteria (Identical last name)

Test Steps:
1. Go to landing page.
2. Click on a CPA property.
3. Click Claim Reward link.
4. Fill out name fields on Lease Report Submission form.
5. Specify today's date as the MID.
6. Submit the lease.
7. Login as a new user and create a lease using the same property ID and renter last name.
8. Submit the second lease.

Expected Result:
Second lease is submitted; system marks status of second lease to "Researching"

=cut

sub test_potential_dupe_criteria_identical_last_name: Test(no_plan)
{
	my ( $self ) = @_;
	
	my $lname = "";
	my $cosign_lname = "";
	my $last_name_first_lease = "";
	my $last_name_second_lease = "";
	
	# create original lease report
	$last_name_first_lease = $self->test_renter_completes_cpa_lease_report($lname, $cosign_lname);
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->open_page("/");
	
	# create second lease report
	print "# Last name first lease = $last_name_first_lease\n";
	$last_name_second_lease = $last_name_first_lease;
	$self->test_renter_completes_cpa_lease_report($last_name_second_lease, $cosign_lname);
}

sub test_potential_dupe_criteria_renter_last_name_original_lease: Test(no_plan)
{
	my ( $self ) = @_;
	
	my $lname = "";
	my $cosign_lname = "";

	# create original lease report
	my ($last_name_first_lease, $cosign_lname_first_lease) = $self->test_renter_completes_cpa_lease_report($lname, $cosign_lname);
	print "# Last name, first lease = $last_name_first_lease\n";
	print "# Cosigner Last name, first lease = $cosign_lname_first_lease\n";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->open_page("/");
	
	# create second lease report using last name of original lease; okay to set $lname to empty
	print "# Last name first lease = $last_name_first_lease\n";
	my $cosign_lname_second_lease = $last_name_first_lease;
	$self->test_renter_completes_cpa_lease_report($lname, $cosign_lname_second_lease);
}

sub test_potential_dupe_criteria_renter_last_name_second_lease: Test(no_plan)
{
	my ( $self ) = @_;
	
	my $lname = "";
	my $cosign_lname = "";

	# create original lease report
	my ($last_name_first_lease, $cosign_lname_first_lease) = $self->test_renter_completes_cpa_lease_report($lname, $cosign_lname);
	print "# Last name, first lease = $last_name_first_lease\n";
	print "# Cosigner Last name, first lease = $cosign_lname_first_lease\n";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->open_page("/");
	
	# create second lease report using cosigner last name of original lease; okay to set $cosign_lname_second_lease to empty
	print "# Last name first lease = $last_name_first_lease\n";
	$lname = $cosign_lname_first_lease;
	my $cosign_lname_second_lease = "";
	$self->test_renter_completes_cpa_lease_report($lname, $cosign_lname_second_lease);
}

sub test_lease_warning_filter(): Test(no_plan)
{
	my($self, $fname, $lname) = @_;

	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $email = $data->create_email();
	# my $fname = $data->create_alpha_string(10);
	# my $lname = $data->create_alpha_string(10);
	my $cosign_fname = '';
	my $cosign_lname = '';
	my $move_in_date = $data->get_todays_date_mmddyyyy();
	my $propertyid =  $leasereportdao->find_valid_lease_property_id();
	
	
	if ($fname eq "")
	{
		$fname = $data->create_alpha_string(10);
	}
	
	if ($lname eq "")
	{
		$lname = $data->create_alpha_string(10);
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
	$searchresultspage->submit_password();
	$searchresultspage->goto_property($propertyid);
	my $propertydescriptionpage = Test::Class::Selenium::PageObjects::PropertyDescriptionPage->new($self);

	SKIP:
	{
		skip('Because lease reports page needs to be looked into further for IE', 2) if($self->{browser_type} eq "*iexploreproxy" || $self->{browser_type} eq "*iexplore");
	
		#click on claim reward
		$propertydescriptionpage->click_claim_reward($propertyid);
		
		my $leasereportpage = Test::Class::Selenium::PageObjects::LeaseReportPage->new($self);
		$leasereportpage->open_page("/lease/detail/?submitted_page=property-selection&linkname=Click_to_claim_button&lease_property_id=".$propertyid);
		ok($leasereportpage->is_text_present("Your New Address"), 'Verify on lease report page');	
		$leasereportpage->fill_moving_here($fname, $lname, $move_in_date, $cosign_fname, $cosign_lname);
		$leasereportpage->submit_lease();
			
		# validate lease status (DB)		
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
		
		my $lease_id = substr( $page_url, $str_offset );
		print ("# Page URL = $page_url\n");
		print ("# Lease ID = $lease_id\n");
		
		my $lease_status = $leasereportdao->check_lease_status( $lease_id );
		ok( $lease_status eq "Researching", 'Verify lease status set to "Researching"' );
		print ("# Lease Status = $lease_status\n");
		
		return ($leasereportpage);
	}
}

sub test_lease_warning_filter_3consecutive_chars(): Test(no_plan)
{
	my ( $self ) = @_;
	
	my @fname = ("---", "Jenny", "bcd", "Kennedy", "fjaed", "'Auina", "Mary");
	my @lname = ("Jones", "aei", "Parker", "bdfhj", "Parker", "Jones", "'Alihi Kaua");
	my $num_fname = scalar(@fname);
	my $num_lname = scalar(@lname);
	
	my $idx = 0;
	
	while ( $idx < $num_fname )
	{
		print "# First Name in lease warning filter - 3 consecutive chars = $fname[$idx]\n";
		print "# Last Name in lease warning filter - 3 consecutive chars = $lname[$idx]\n";
		my $leasereportpage = $self->test_lease_warning_filter($fname[$idx], $lname[$idx]);
		
		$leasereportpage->sign_out();
		
		my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
		$loginpage->open_page("/");

		$idx++;
	}
}

sub test_lease_warning_filter_punctuation_space(): Test(no_plan)
{
	my ( $self ) = @_;
	
	my @fname = ("bob & barbara", "James", "bcd");
	my @lname = ("Jones", "aei", "Jones, Sr.");
	my $num_fname = scalar(@fname);
	my $num_lname = scalar(@lname);
	
	my $idx = 0;
	
	while ( $idx < $num_fname )
	{
		print "# First Name in lease warning filter - punctuation + space first name = $fname[$idx]\n";
		print "# Last Name in lease warning filter - punctuation + space first name = $lname[$idx]\n";
		my $leasereportpage = $self->test_lease_warning_filter($fname[$idx], $lname[$idx]);
		
		$leasereportpage->sign_out();
		
		my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
		$loginpage->open_page("/");

		$idx++;
	}
	
	
}

sub test_lease_warning_filter_no_alphabeticals(): Test(no_plan)
{
	my ( $self ) = @_;
	
	my $fname = "Jenny";
	my $lname = "123-57-8902";
	
	print "# First Name in lease warning filter - no alphabeticals test = $fname\n";
	print "# Last Name in lease warning filter - no alphabeticals test = $lname\n";
	$self->test_lease_warning_filter($fname, $lname);
}

sub test_fraud_filters(): Test(no_plan)
{
	my $self = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $leasereportdao = Test::Class::Selenium::DataAccessObjects::LeaseReportDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	
	# ========== CONDITION 1:  Property that was terminated before renter registration ==========
	# search for first active property in the DB
	my $propertyid =  $leasereportdao->find_valid_lease_property_id();
	
	# change terminate date of property to an earlier date
	my $dt = DateTime->now( time_zone => 'America/Los_Angeles' );
	my $term_dt = $dt->subtract( days => 29 );
	my $terminate_date= $term_dt->mdy('/');
	
	ok($leasereportdao->modify_property_terminate_date( $propertyid, $terminate_date ), 'Verify terminate_date is modified');
	
	
	# register new renter
	
	# new renter completes lease report on terminated property
	
	# compare renter create date VS property terminate date in the DB
	
	# check page for proper error message; return ok condition if correct page and message is displayed
	
	# ========= CONDITION 3a:  Lease report is 30 days past property termination date ===========
	
	# search for first active property in the DB
	
	# change terminate date of property to an earlier date (31 days or more in the past)
	
	# login using an existing renter
	
	# renter completes lease report on terminated property
	
	# get lease id
	
	# compare lease report create date VS. property's terminate date
	
	# check page for proper error message; return ok condition if correct page and message is displayed
	
	# ========== CONDITION 3b:  Lease is reported for a property that has a status of "Terminated - Unusual Activity"
	
	# search for first active property in the DB
	
	# change terminate date of property to an earlier date and 
	# terminate_xt status of property to "Terminated - Unusual Activity"
	
	# login using an existing renter
	
	# renter completes report on terminated property
	
	# check page for proper error message; return ok condition if correct page and message is displayed
	
	# ========== CONDITION 4:  Person reported another lease while the reward status page was displayed =====
	
	# ******* SKIP FOR NOW UNTIL REWARD STATUS PAGE IS PUSHED TO QA-07 ********
	
	# ========== CONDITION 5:  Property ID is not recognized ============
	
	# ========== CONDITION 6:  Property is not a CPA property ============
}


1;

}

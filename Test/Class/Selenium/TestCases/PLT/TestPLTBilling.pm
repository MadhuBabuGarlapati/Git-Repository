package Test::Class::Selenium::TestCases::PLT::TestPLTBilling;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::DataAccessObjects::PropertyDao;
use Test::Class::Selenium::DataAccessObjects::BillingDao;
use Test::Class::Selenium::PageObjects::LandingPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Class::Selenium::Util::DateCalculate;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::PLT::TestPLT';

=head1 NAME

TestPLTLeftNavLinks - This Test Class verifies the left navigation links for a PLT lessor.

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_plt_active_status_on_dashboard

Verify Display status of "Active" on Dashboard 

Test Step:

=over

=item 1. Login with a user with terminate_xt = 'Active'

=back

Expected Result:
Login as PLT user, listing DashBoard should say Active

=cut

sub test_plt_active_status_on_dashboard:Test(no_plan)
{

	my($self) = @_;	
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $property_id = "";
	my $pltusername = "";
	my $pltpassword = "";
	my $property_nm = "";

	my $businessmodel_tp = 'plt';
	
	my $propertydao = Test::Class::Selenium::DataAccessObjects::PropertyDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	$property_id = $propertydao->get_most_recent_property_by_businessmodel_tp_is_searchable($businessmodel_tp);
	$pltusername = $propertydao->get_person_nm_by_property_id($property_id);
	$pltpassword = $propertydao->get_person_cd_by_property_id($property_id);
	$property_nm = $propertydao->get_property_nm_by_property_id($property_id);

	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);

	$loginpage->sign_in($pltusername,$pltpassword);	
	ok($loginpage->wait_for_text_present('Sign Out', '30000'), 'Verify User is logged in');
	
	$loginpage->click_manage_your_property();

	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	
	$manageraccountpage->wait_for_text_present('Active', '30000');
	ok($manageraccountpage->is_text_present("Active"), 'Verify dashboard displays \'Active\'');
	ok($manageraccountpage->is_text_present($property_nm), 'Verify property name is present'); 

}

=head3 test_plt_prereg_underreview_status_on_dashboard

Verify Display status of "Under Review" on Dashboard 

Test Step:

=over

=item 1. Login with a user with terminate_xt = 'Pre-Registered (Not yet Activated)'

=back

Expected Result:
Login as PLT user, listing DashBoard should say "Under Review"

=cut

sub test_plt_prereg_underreview_status_on_dashboard:Test(no_plan)
{

	my($self) = @_;	
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $property_id = "";
	my $pltusername = "";
	my $pltpassword = "";
	my $property_nm = "";
	my $approved_fg = "0";

	my $terminate_xt = 'Pre-Registered (Not yet Activated)';
	my $businessmodel_tp = 'plt';
	
	my $propertydao = Test::Class::Selenium::DataAccessObjects::PropertyDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	
	$property_id = $propertydao->get_most_recent_property_by_terminate_xt_and_businessmodel_tp($terminate_xt, $businessmodel_tp);
	$pltusername = $propertydao->get_person_nm_by_property_id($property_id);
	$pltpassword = $propertydao->get_person_cd_by_property_id($property_id);
	$property_nm = $propertydao->get_property_nm_by_property_id($property_id);

	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);

	$loginpage->sign_in($pltusername,$pltpassword);	
	
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
	
	$loginpage->click_manage_your_property();

	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->wait_for_text_present("Under Review", $self->{set_timeout});
	
	ok($manageraccountpage->is_text_present("Under Review"), 'Verify dashboard displays \'Under Review\'');
	ok($manageraccountpage->is_text_present($property_nm), 'Verify property name is present'); 

}

=head3 test_plt_billing_period

Verify the end date is set to 60 days from the current date (making the entire period 61 days long) -> Verify in tblbillingperiod end_dm = 2 months from today

Verify the minimum cut off date is set to 30 days from the current date (making the entire period 31 days long) -> Verify in tblbillingperiod min_cutoff_dm = 1 month from today

Verify the minimum leads is set to 15 -> Verify in tblbillingperiod min_units = 15

Test Steps:

=over

=item 1. Get newly activated property

=item 2. Approve image

=item 3. run ./bundled_charges"

select * from tblcctransaction where cctransaction_id = (select cctransaction_id from TBLBILLINGPERIOD_CCTRANSACTION where billingperiod_id = 30596288);
Please note: a record also gets inserted in tblcctransaction as soon as PLT property is created. That is for tblcctransaction.Type_NM = Authorization. "

=back

Expected Result:
end date is set to 60 days from the current date (making the entire period 61 days long)

minimum cut off date is set to 30 days from the current date (making the entire period 31 days long)

minimum leads is set to 15

=cut

sub test_plt_billing_period:Test(no_plan)
{
	my($self) = @_;	
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $date = Test::Class::Selenium::Util::DateCalculate->new();
	my $property_id = "";	
	my $terminate_xt = 'Active';
	my $businessmodel_tp = 'plt';
	my %billingperiod;
	
	my $propertydao = Test::Class::Selenium::DataAccessObjects::PropertyDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	$property_id = $propertydao->get_most_recent_property_by_terminate_xt_and_businessmodel_tp($terminate_xt, $businessmodel_tp);

	my $billingdao = Test::Class::Selenium::DataAccessObjects::BillingDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	%billingperiod = $billingdao->get_most_recent_billingperiod_hash_by_property_id($property_id);
	
	#Verify the end date is set to 60 days from the current date (making the entire period 61 days long) -> Verify in tblbillingperiod end_dm = 2 months from today
	my $end_dm_delta = $date->calculate_num_of_days_between_two_dates($billingperiod{start_dm}, $billingperiod{end_dm});
	ok(($end_dm_delta == 60), 'Verify the end date is 60 days after start date');
	#print "\nENDDAYS:".$end_dm_delta."\n";

	#Verify the minimum cut off date is set to 30 days from the current date (making the entire period 31 days long) -> Verify in tblbillingperiod min_cutoff_dm = 1 month from today
	my $mincutoff_dm_delta = $date->calculate_num_of_days_between_two_dates($billingperiod{start_dm}, $billingperiod{min_cutoff_dm});
	ok(($mincutoff_dm_delta == 30), 'Verify the minimum cut off date is 30 days after start date');
	#print "\nMINCUTOFFDAYS:".$mincutoff_dm_delta."\n";

	#Verify the minimum leads is set to 15 -> Verify in tblbillingperiod min_units = 15
	ok(($billingperiod{min_units} == 15), 'Verify the minimum leads is set to 15');
	#print "#\nMINLEADS:".$billingperiod{min_units}."\n";

}

=head3 test_time_remaining_on_dashbaord

Verify days remaining on dashbaord are displaying correctly, should display 'N days' if a new property

Test Steps:

=over

=item 1.  Login as PLT user
=item 2.  Goto the Listing Dashboard

=back

Expected Result:
Days remaining on dashbaord, ((mincutoff_dm - start_dm) == (to whats displaying on the listing dashboard)).

=cut

sub test_time_remaining_on_dashbaord:Test(no_plan)
{
	my($self) = @_;	
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $date = Test::Class::Selenium::Util::DateCalculate->new();
	my $username = "";
	my $password = "";
	my $property_id = "";	
	my $property_nm = "";
	my $terminate_xt = 'Active';
	my $businessmodel_tp = 'plt';
	my %billingperiod;
	my $todays_date = $data->get_todays_date_ddMMMyy();
			
	#Get new existing property
	my $propertydao = Test::Class::Selenium::DataAccessObjects::PropertyDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	$property_id = $propertydao->get_most_recent_property_by_terminate_xt_and_businessmodel_tp($terminate_xt, $businessmodel_tp);
	$username = $propertydao->get_person_nm_by_property_id($property_id);
	$password = $propertydao->get_person_cd_by_property_id($property_id);
	$property_nm = $propertydao->get_property_nm_by_property_id($property_id);

	
	#log in
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username, $password);		
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();
	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);

	my $billingdao = Test::Class::Selenium::DataAccessObjects::BillingDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	%billingperiod = $billingdao->get_most_recent_billingperiod_hash_by_property_id($property_id);
	
	#Obtain date delta, (todays date) - (min cut off)
	my $date_delta = $date->calculate_num_of_days_between_two_dates($todays_date, $billingperiod{min_cutoff_dm});
	#print "\nMINCUTOFFDAYS:".$mincutoff_dm_delta."\n";
	
	ok($manageraccountpage->is_text_present($date_delta." Days"), 'Verify '.$date_delta.' Days left');
	ok($manageraccountpage->is_text_present($property_nm), 'Verify property name '.$property_nm.' is present');
	ok($manageraccountpage->is_page_title_present("Rent.com: Manager Site: Account"), 'Verify page title: Rent.com: Manager Site: Account');

}

=head3 test_renew_option_on_dashboard_active_status

Verify Renew option on Listing Dashboard functions as expected
* This test case uses a property/listing with a status of 'Active'

Test Steps:

=over

=item 1.  Login as PLT user

=item 2.  Goto the Listing Dashboard

=back

Expected Result(s):

=over

=item a.  Renew Status column displays current option

=item b.  Option displayed in Listing Dashboard matches value saved in the DB

=item c.  Change link appears next to Renew Status ('Active' or 'Pending' dashboard statuses only)

=back

=cut

sub test_renew_option_on_dashboard_active_status:Test(no_plan)
{
	my ( $self ) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $username = "";
	my $password = "";
	my $property_id = "";	
	my $property_nm = "";
	my $terminate_xt = 'Active';
	my $businessmodel_tp = 'plt';
	my $todays_date = $data->get_todays_date_ddMMMyy();
	
	print "# Terminate XT = $terminate_xt\n";
				
	#Get new existing property
	my $propertydao = Test::Class::Selenium::DataAccessObjects::PropertyDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	$property_id = $propertydao->get_most_recent_property_by_terminate_xt_and_businessmodel_tp($terminate_xt, $businessmodel_tp);
	$username = $propertydao->get_person_nm_by_property_id($property_id);
	$password = $propertydao->get_person_cd_by_property_id($property_id);
	$property_nm = $propertydao->get_property_nm_by_property_id($property_id);
	
	#log in
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username, $password);		
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();
		
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	
	my $billingdao = Test::Class::Selenium::DataAccessObjects::BillingDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	# Get property's current renew status
	my $renew_status = $billingdao->get_property_renew_status( $property_id );
		
	# Create hash of PLT renew options and compare renew status in DB
	# with status displayed in the Listing Dashboard
	my %renew_options = ("0" => "Off",
		"1" => "Once",
		"2" => "Auto");
		
	my $renew_option = $renew_options{$renew_status};
	print "# Expected Renew Option is ".$renew_option."\n";
		
	ok($manageraccountpage->is_text_present($renew_option), 'Verify property renew status is set to \''.$renew_option.'\'');
	ok($manageraccountpage->is_text_present($renew_option." (change)"),'Verify \'Change\' link appears next to renew status');
	ok($manageraccountpage->is_text_present($property_nm), 'Verify property name '.$property_nm.' is present');
	ok($manageraccountpage->is_page_title_present("Rent.com: Manager Site: Account"), 'Verify page title: Rent.com: Manager Site: Account');
}

=head3 test_renew_option_on_dashboard_active_status

Verify Renew option on Listing Dashboard functions as expected
* This test case uses a property/listing with a status of 'Pending'

Test Steps:

=over

=item 1.  Login as PLT user

=item 2.  Goto the Listing Dashboard

=back

Expected Result(s):

=over

=item a.  Renew Status column displays current option

=item b.  Option displayed in Listing Dashboard matches value saved in the DB

=item c.  Change link appears next to Renew Status ('Active' or 'Pending' dashboard statuses only)

=back

=cut

sub test_renew_option_on_dashboard_pending_status:Test(no_plan)
{
	my ( $self ) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $username = "";
	my $password = "";
	my $property_id = "";	
	my $property_nm = "";
	my $terminate_xt = 'Pre-Registered (Not yet Activated)';
	my $businessmodel_tp = 'plt';
	my $todays_date = $data->get_todays_date_ddMMMyy();
	
	print "# Terminate XT = $terminate_xt\n";
				
	#Get new existing property
	my $propertydao = Test::Class::Selenium::DataAccessObjects::PropertyDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	$property_id = $propertydao->get_most_recent_property_by_terminate_xt_and_businessmodel_tp($terminate_xt, $businessmodel_tp);
	$username = $propertydao->get_person_nm_by_property_id($property_id);
	$password = $propertydao->get_person_cd_by_property_id($property_id);
	$property_nm = $propertydao->get_property_nm_by_property_id($property_id);
	
	#log in
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username, $password);		
	
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
	
	$loginpage->click_manage_your_property();
		
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	
	my $billingdao = Test::Class::Selenium::DataAccessObjects::BillingDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	# Get property's current renew status
	my $renew_status = $billingdao->get_property_renew_status( $property_id );
		
	# Create hash of PLT renew options and compare renew status in DB
	# with status displayed in the Listing Dashboard
	my %renew_options = ("0" => "Off",
		"1" => "Once",
		"2" => "Auto");
		
	my $renew_option = $renew_options{$renew_status};
	print "# Expected Renew Option is ".$renew_option."\n";
		
	ok($manageraccountpage->is_text_present($renew_option), 'Verify property renew status is set to \''.$renew_option.'\'');
	ok($manageraccountpage->is_text_present($renew_option." (change)"),'Verify \'Change\' link appears next to renew status');
	ok($manageraccountpage->is_text_present($property_nm), 'Verify property name '.$property_nm.' is present');
	ok($manageraccountpage->is_page_title_present("Rent.com: Manager Site: Account"), 'Verify page title: Rent.com: Manager Site: Account');
}

=head3 test_renew_option_change_on_dashboard

Verify Renew option on Listing Dashboard functions as expected

Test Steps:

=over

=item 1.  Login as PLT user

=item 2.  Goto the Listing Dashboard

=item 3.  Change Active listing's Renew Status

=back

Expected Result(s):

=over

=item a.  Renew Status column displays current option

=item b.  Option popup appears when "Change" link is clicked

=item c.  Renew Status column is updated with selected option when changed

=item d.  Option displayed in Listing Dashboard matches value saved in the DB

=back

=cut
sub test_renew_option_change_on_dashboard:Test(no_plan)
{
	my ( $self ) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $username = "";
	my $password = "";
	my $property_id = "";	
	my $property_nm = "";
	my $terminate_xt = 'Active';
	my $businessmodel_tp = 'plt';
	my $todays_date = $data->get_todays_date_ddMMMyy();
			
	#Get new existing property
	my $propertydao = Test::Class::Selenium::DataAccessObjects::PropertyDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	$property_id = $propertydao->get_most_recent_property_by_terminate_xt_and_businessmodel_tp($terminate_xt, $businessmodel_tp);
	$username = $propertydao->get_person_nm_by_property_id($property_id);
	$password = $propertydao->get_person_cd_by_property_id($property_id);
	$property_nm = $propertydao->get_property_nm_by_property_id($property_id);

	#log in
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($username, $password);		
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();
	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);

	my $billingdao = Test::Class::Selenium::DataAccessObjects::BillingDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	# Get property's current renew status
	my $renew_status = $billingdao->get_property_renew_status( $property_id );
	
	# Create hash of PLT renew options and compare current renew status in DB
	# with status displayed in the Listing Dashboard.
	my %renew_options = ("0" => "Off",
		"1" => "Once",
		"2" => "Auto");
	
	my $renew_option = $renew_options{$renew_status};
	print "# Current Renew Option in Listing Dashboard = ".$renew_option."\n";
	
	ok($manageraccountpage->is_text_present($renew_option), 'Verify current renew status of property is set to \''.$renew_option.'\'');
	
	# Create hash of PLT renew options in UI and compare current renew status in Listing Dashboard
	# with status saved/written to the DB for the specified property.
	# Comparison will be done after Renew Status has been changed in the dashboard.
	my %renew_options_ui_to_db = ("Off" => "0",
		"Once" => "1",
		"Auto" => "2");
		
	# assumes PLT listing is active; this portion of the script will fail if listing is inactive	
	$manageraccountpage->click_renew_status_change_link( $property_id ); 
	
	my $updated_renew_option = "";
		
	SWITCH:
	{
		$renew_option eq "Off" && do {
			$manageraccountpage->click_renew_option_once();
			$updated_renew_option = $renew_options_ui_to_db{"Once"};
			ok($manageraccountpage->is_text_present("Once"), 'Verify Renew status is now set to \'Once\'');
			last SWITCH;
		};
		$renew_option eq "Once" && do {
			$manageraccountpage->click_renew_option_auto();
			$updated_renew_option = $renew_options_ui_to_db{"Auto"};
			ok($manageraccountpage->is_text_present("Auto"), 'Verify Renew status is now set to \'Auto\'');
			last SWITCH;
		};
		$renew_option eq "Auto" && do {
			$manageraccountpage->click_renew_option_off();
			$updated_renew_option = $renew_options_ui_to_db{"Off"};			
			ok($manageraccountpage->is_text_present("Off"), 'Verify Renew status is now set to \'Off\'');
			last SWITCH;
		};
		print "## Unable to change Renew Status option!\n";
	}
	
	# Verify changed renew status matches value in the DB for the specified property/listing
	ok($updated_renew_option == $billingdao->get_property_renew_status( $property_id ), 'Verify Changed Renew Status matches value in DB');
	
	# Verify lessor remains in Listing Dashboard post-Renew Status change
	ok($manageraccountpage->is_text_present($property_nm), 'Verify property name '.$property_nm.' is present');
	ok($manageraccountpage->is_page_title_present("Rent.com: Manager Site: Account"), 'Verify page title: Rent.com: Manager Site: Account');
}

1;

}
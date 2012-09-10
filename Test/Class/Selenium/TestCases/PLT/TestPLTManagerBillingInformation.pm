package Test::Class::Selenium::TestCases::PLT::TestPLTManagerBillingInformation;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

TestPLTManagerBillingInformation - This Test Class verifies existing plt renters billing information

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_edit_company_info

Verify editing company information in billing section

Test Steps:

=over

=item 1. Login to qa as a small property lessor

=item 2. Go to manage account page

=item 3. Click on Billing link

=item 4. Modify and Save new Company info

=back

Expected Result:

Company information is entered and successfully edited

=cut

sub test_edit_company_info: Test(no_plan)
{
	my($self) = @_;	
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $company_name = $data->create_alpha_string(8);
	my $first_name = $data->create_alpha_string(5);
	my $last_name = $data->create_alpha_string(5);
		
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{plt_username},$self->{plt_password});		
	ok($loginpage->is_text_present("Welcome"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();
	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_billing_information();
	
	my $managerbillinginformation = Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation->new($self);
	$managerbillinginformation->click_my_info_edit();
	$managerbillinginformation->submit_company_info($company_name);
	
	#ASSERT COMPANY INFORMATION
	$managerbillinginformation->wait_for_text_present($company_name, $self->{set_timeout});

	ok($managerbillinginformation->is_text_present("My Information"), 'Verify \'My Information\' is present');
	ok($managerbillinginformation->is_text_present($company_name), 'Verify successfully updated company name');
	ok($managerbillinginformation->is_text_present("Company:"), 'Verify \'Company:\' is present');
}

=head3 test_edit_company_info_missing_data

Verify editing company information in billing section when missing data

Test Steps:

=over

=item 1. Login to qa as a small property lessor

=item 2. Go to manage account page

=item 3. Click on Billing link

=item 4. Modify Company info without phone number field

=back

Expected Result:

system returns error for missing phone number

=cut

sub test_edit_company_info_missing_data: Test(no_plan)
{
	my($self) = @_;	
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $company_name = $data->create_alpha_string(8);
	my $first_name = $data->create_alpha_string(5);
	my $last_name = $data->create_alpha_string(5);
	my $phone_num = "";

	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{plt_username},$self->{plt_password});		
	ok($loginpage->is_text_present("Welcome"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();

	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_billing_information();

	my $managerbillinginformation = Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation->new($self);
	$managerbillinginformation->click_my_info_edit();
	$managerbillinginformation->fill_phonenumber($phone_num);
	$managerbillinginformation->click_submit();

	#ASSERT COMPANY INFORMATION
	$managerbillinginformation->wait_for_text_present("Please enter one 10-digit US phone number, including area code.", $self->{set_timeout});

	ok($managerbillinginformation->is_text_present("Please enter one 10-digit US phone number, including area code."), 'Verify error message, Please enter one 10-digit US phone number, including area code.');
	ok($managerbillinginformation->is_text_present("Company Name"), 'Verify still on Edit My Information pop-up');
	ok($managerbillinginformation->is_text_present("*Optional fields"), 'Verify still on Edit My Information pop-up');	

}

=head3 test_edit_company_with_toll_free_number

Verify editing company information in billing section when using toll free number

Test Steps:

=over

=item 1. Login to qa as a small property lessor

=item 2. Go to manage account page

=item 3. Click on Billing link

=item 4. Modify Company info with toll free phone number field

=back

Expected Result:

Company info gets updated

=cut

sub test_edit_company_with_toll_free_number: Test(no_plan)
{
	my($self) = @_;	
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $company_name = $data->create_alpha_string(8);
	my $first_name = $data->create_alpha_string(5);
	my $last_name = $data->create_alpha_string(5);
	my $phone_num = "(800) 318-7118";

	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{plt_username},$self->{plt_password});		
	ok($loginpage->is_text_present("Welcome"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();

	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_billing_information();

	my $managerbillinginformation = Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation->new($self);
	$managerbillinginformation->click_my_info_edit();
	$managerbillinginformation->submit_phonenumber_company($phone_num, $company_name);

	#ASSERT COMPANY INFORMATION

	ok($managerbillinginformation->is_text_present("My Information"), 'Verify \'My Information\' is present');
	ok($managerbillinginformation->is_text_present($company_name), 'Verify successfully updated company name');
	ok($managerbillinginformation->is_text_present("Company:"), 'Verify \'Company:\' is present');
	ok($managerbillinginformation->is_text_present("$phone_num"), 'Verify \'Phone:\' is present');

}

=head3  test_edit_credit_card

Verify editing credit card in billing section

Test Steps:

=over

=item 1. Login to qa as a small property lessor

=item 2. Go to manage account page

=item 3. Click on Billing link

=item 4. Modify and Save new credit card info

=back

Expected Result:

New creditcard info is entered and successfully edited

=cut

sub test_edit_credit_card: Test(no_plan)
{
	my($self) = @_;
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $companyname = $data->create_alpha_string(8);
	my $fnameoncard = $data->create_alpha_string(5);
	my $mnameoncard = $data->create_alpha_string(1);
	my $lnameoncard = $data->create_alpha_string(5);
	my $address = $data->create_address(5);	
	my $cctype = "VISA";
	my $ccnumber = "4111111111111111";
	my $cc_expmonth = "Dec";
	my $cc_expyear = "2019";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{plt_username},$self->{plt_password});		
	ok($loginpage->is_text_present("Welcome"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();
	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_billing_information();
	
	my $managerbillinginformation = Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation->new($self);

	$managerbillinginformation->click_edit_credit_card();
    $managerbillinginformation->submit_credit_card($companyname, $fnameoncard, $mnameoncard, $lnameoncard, $address, $cctype, $ccnumber, $cc_expmonth, $cc_expyear);

	#ASSERT BILLING INFO
	$managerbillinginformation->wait_for_text_present($fnameoncard, $self->{set_timeout});

	#ok($managerbillinginformation->is_text_present($companyname), 'Verify companyname updated');
	ok($managerbillinginformation->is_text_present($fnameoncard), 'Verify first name on card updated');
	ok($managerbillinginformation->is_text_present($mnameoncard), 'Verify middle name on card updated');
	ok($managerbillinginformation->is_text_present($lnameoncard), 'Verify last name on card updated');	
	ok($managerbillinginformation->is_text_present($address), 'Verify address updated');

	ok($managerbillinginformation->is_text_present($cctype), 'Verify cc type updated');
	ok($managerbillinginformation->is_text_present("ending in ".substr($ccnumber, -4)), 'Verify cc number updated');
	ok($managerbillinginformation->is_text_present($cc_expmonth), 'Verify cc expire month updated');
	ok($managerbillinginformation->is_text_present($cc_expyear),'Verify cc expire year updated');

}

=head3 test_invalid_credit_card

Verify apltication does not allow saving an invalid credit card number in billing section

Test Steps:

=over

=item 1. Login to QA as a PLT lessor

=item 2. Go to Manage Account page

=item 3. Click on Billing Information link (from left nav)

=item 4. Click on Credit Card tab 

=item 5. Click on Edit link

=item 6. Enter an invalid credit card number, valid CVV, Expiration Date and Billing Address

=item 7. Click on Save Changes button 

=back

Expected Result:

Apltication should display an error message - "Invalid credit card number" 

=cut

sub test_invalid_credit_card: Test(no_plan)
{
	my($self) = @_;
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $companyname = $data->create_alpha_string(8);
	my $fnameoncard = $data->create_alpha_string(5);
	my $mnameoncard = $data->create_alpha_string(1);
	my $lnameoncard = $data->create_alpha_string(5);
	my $address = $data->create_address(5);	
	my $cctype = "VISA";
	my $ccnumber = "123456781234";
	my $cc_expmonth = "Dec";
	my $cc_expyear = "2019";
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{plt_username},$self->{plt_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();
	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_billing_information();
	
	my $managerbillinginformation = Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation->new($self);
	$managerbillinginformation->click_edit_credit_card();
    $managerbillinginformation->fill_credit_card_info($cctype, $ccnumber, $cc_expmonth, $cc_expyear);
    $managerbillinginformation->fill_billing_address($companyname, $fnameoncard, $mnameoncard, $lnameoncard, $address);
    $managerbillinginformation->click_submit();

	#ASSERT BILLING INFO
	ok($managerbillinginformation->is_text_present("Invalid credit card number"), 'Verify expected error message for invalid credit card number is displayed');
	ok($managerbillinginformation->is_text_present("Credit Card Information"), 'Verify Billing Information label is present');
	ok($managerbillinginformation->is_text_present("Billing Address"), 'Verify Verify Billing Address label is present');
	
}

=head3 test_edit_credit_card_expired_cc

Verify system catches expired credit card in billing section

Test Steps:

=over

=item 1. Login to qa as a small property lessor

=item 2. Go to manage account page

=item 3. Click on Billing link

=item 4. Modify and Save new credit card info with an expired CC 

=back

Expected Result:

New creditcard info is entered system returns an error for expired CC

=cut

sub test_edit_credit_card_expired_cc: Test(no_plan)
{
	my($self) = @_;
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $companyname = $data->create_alpha_string(8);
	my $fnameoncard = $data->create_alpha_string(5);
	my $mnameoncard = $data->create_alpha_string(1);
	my $lnameoncard = $data->create_alpha_string(5);
	my $address = $data->create_address(5);	
	my $cctype = "VISA";
	my $ccnumber = "4012888888881881";
	my $cc_expmonth = "Jan";
	my $cc_expyear = "2012";

	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	$loginpage->sign_in($self->{plt_username},$self->{plt_password});		
	ok($loginpage->is_text_present("Sign Out"), 'Verify User is logged in');
	$loginpage->click_manage_your_property();

	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_billing_information();

	my $managerbillinginformation = Test::Class::Selenium::PageObjects::PLT::ManagerBillingInformation->new($self);
	$managerbillinginformation->click_edit_credit_card();
    $managerbillinginformation->fill_credit_card_info($cctype, $ccnumber, $cc_expmonth, $cc_expyear);
    $managerbillinginformation->fill_billing_address($companyname, $fnameoncard, $mnameoncard, $lnameoncard, $address);
    $managerbillinginformation->click_submit();

	#ASSERT Error Message
	ok($managerbillinginformation->is_text_present("This credit card has expired. Please use another card"), 'Verify error message, This credit card has expired. Please use another card');	
	ok($managerbillinginformation->is_text_present("Credit Card Information"), 'Verify Billing Information label is present');
	ok($managerbillinginformation->is_text_present("Billing Address"), 'Verify Verify Billing Address label is present');

}

1;

}

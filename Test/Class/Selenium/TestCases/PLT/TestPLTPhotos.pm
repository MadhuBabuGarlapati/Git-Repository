package Test::Class::Selenium::TestCases::PLT::TestPLTPhotos;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage;
use Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage;
use Test::Class::Selenium::PageObjects::PLT::AddPhotosPage;
use Test::Class::Selenium::Util::GenerateData;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::PLT::TestPLT';

=head1 NAME

TestPLTPhotos - This Test Class verifies existing PLT lessors

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_plt_add_photo

Verify adding a main image to an existing PLT property with no main image

Test Steps:

=over

=item 1.  Create a new PLT lessor
=item 2.  At 'Manage your property' page click on 'Add Photos'
=item 3.  Click 'upload additional property images'
=item 4.  Upload a main image

=back

Expected Results:

User should be able to add a new main image

=cut

sub test_plt_add_photo: Test(no_plan)
{
	my($self) = @_;
	
	my $data = Test::Class::Selenium::Util::GenerateData->new();
	my $email = $data->create_email();
	my $propertyaddressone = $data->create_address(5);
	my $propertyname = $data->create_alpha_string(10);
	my $zipcode = "90404";
	my $phonenum = "(310) 844-8952";

	$self->go_to_plt_page_single_vacancy($zipcode);
	
	my $pltregistrationpageone = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationOnePage->new($self);

	$pltregistrationpageone->continue_to_step_two($email, "qatest11", $propertyaddressone, "Santa Monica", "CA", $zipcode, "1200");
	$pltregistrationpageone->pause("30000");
	ok($pltregistrationpageone->is_text_present("Basic Listing Information"), 'Verify Property registration page 2');

	my $pltregistrationpagetwo = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationTwoPage->new($self);
	$pltregistrationpagetwo->continue_to_step_three($self->{filepath}, $propertyname, $email, $phonenum);
	
	my $pltregistrationpagethree = Test::Class::Selenium::PageObjects::PLT::PLTRegistrationThreePage->new($self);
	ok($pltregistrationpagethree->is_text_present("Submit your listing today and start receiving leads!"), 'Verify Property registration page 3');		
	$pltregistrationpagethree->submit_listing();
	
	ok($pltregistrationpagethree->is_text_present("Thank you for using Rent.com to fill your vacancies!"), 'Verify Successful registration');
	$pltregistrationpagethree->click_manage_my_listings();
	
	#click add new listing	
	my $manageraccountpage = Test::Class::Selenium::PageObjects::PLT::ManagerAccountPage->new($self);
	$manageraccountpage->click_add_photos();
	
	my $addphotospage = Test::Class::Selenium::PageObjects::PLT::AddPhotosPage->new($self);
	$addphotospage->click_upload_property_images();
	$addphotospage->upload_image($self->{filepath});

	ok($addphotospage->is_text_present("Images currently being reviewed by Rent.com"), 'Verify back to add photo page after uploading of photo');
	ok($addphotospage->is_text_present("Delete"), 'Verify Delete option is present for image');
}

1;

}

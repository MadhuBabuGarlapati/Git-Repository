package Test::Class::Selenium::TestCases::CSTool::TestCSToolNewContent;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Class::Selenium::PageObjects::CSTool::NewContentPage;
use Test::Class::Selenium::DataAccessObjects::NewContentDao;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::CSTool::CSTool';

=head1 NAME

TestCSToolNewContent - This Test Class verifies search NewContent tab

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_approval_for_plt_lessor_main_img

Verify approval of new main img for new PLT lessor registration

Test Steps:

=over

=item 1. register as a new plt lessor and get new property id (we actually cheat here and get_most_recent_unapproved_img_for_a_plt_property)

=item 2. login as cs-tool user

=item 3. click on manage property

=item 4. click on new content tab

=item 5. search for img by property id

=item 6.  approve new image

=back

Expected Result:

=over

=item Verify in tblnewcontent that image has been approved (terminate_xt = approved)

=item Verify in tblnewcontent that image has been approved (approved_fg = 1)

=back

=cut

sub test_approval_for_plt_lessor_main_img: Test(no_plan)
{
	my($self) = @_;	
	my $newcontentdao = Test::Class::Selenium::DataAccessObjects::NewContentDao->new($self->{database}, $self->{db_username}, $self->{db_password});
	my $property_id = '';
	my $terminate_xt = '';
	my $approved_fg = '';

    $self->sign_in_as_csuser();
	my $cstool_newcontentpage = Test::Class::Selenium::PageObjects::CSTool::NewContentPage->new($self);    	
	#click on new content tab
	$cstool_newcontentpage->click_newcontent_tab();
	#type property id
	$property_id = $newcontentdao->get_most_recent_unapproved_img_for_a_plt_property();
	$cstool_newcontentpage->type_property_id($property_id);	
	#click go
	$cstool_newcontentpage->click_go();		
	#click on approve radio button
	$cstool_newcontentpage->click_radio_button_approved_img($property_id);
	#click submit
	$cstool_newcontentpage->click_submit();	
	
	$terminate_xt = $newcontentdao->get_terminate_xt_by_object_id($property_id);
	$approved_fg = $newcontentdao->get_approved_fg_by_object_id($property_id);

	ok($terminate_xt eq 'approved', 'Verify in tblnewcontent that image has been approved (terminate_xt = approved)');
	ok($approved_fg eq '1', 'Verify in tblnewcontent that image has been approved (approved_fg = 1)');

}

1;

}
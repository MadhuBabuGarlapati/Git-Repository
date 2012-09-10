package Test::Class::Selenium::TestCases::Akamai::TestImagesOnAkamai;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::LoggedOut::LoggedOutPropertyDescriptionPage;
use Test::Class::Selenium::Util::HTTP;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';
use WWW::Mechanize;

=head1 NAME

TestImagesOnAkamai - This Test Class verifies images on Akamai

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}


=head3 test_pdp_logged_out_image()

Verify image on the logged out pdp page(http://media.rent.com/property/test-rentcom-property-and-lroff-apartment-for-rent-redfield-sd-57469/90658447.gif) does not redirect to http://www.rent.com/property/
IB-8294

Test Steps:

=over

=item 1. Go to the logged out page
http://www.rent.com/rentals/south-dakota/spink-county/redfield/test-rentcom-property-and-lroff/427608/

=item 2. Open the image on the page (http://media.rent.com/property/test-rentcom-property-and-lroff-apartment-for-rent-redfield-sd-57469/90658447.gif)

=back

Expected Result:

Verify Image does not redirect to http://www.rent.com/property/test-rentcom-property-and-lroff-apartment-for-rent-redfield-sd-57469/90658447.gif

=cut

sub test_pdp_logged_out_image: Test(no_plan)
{
	
	my($self) = @_;
	
	my $akamai_img_url = 'http://media.rent.com/property/test-rentcom-property-and-lroff-apartment-for-rent-redfield-sd-57469/90658447.gif';
	my $http = Test::Class::Selenium::Util::HTTP->new();

	my $response = $http->get($akamai_img_url);
	
	ok($response->is_success, 'Verify akamai image returns sucessful: '.$akamai_img_url);
	ok($http->uri() eq $akamai_img_url, 'Verify akamai image does not return a redirected uri');


}

1;

}

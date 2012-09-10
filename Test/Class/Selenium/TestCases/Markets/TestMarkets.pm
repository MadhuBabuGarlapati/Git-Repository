package Test::Class::Selenium::TestCases::Markets::TestMarkets;

use strict;
use warnings;

use Test::Class::Selenium::DataAccessObjects::MarketsDao;
use Test::Class::Selenium::PageObjects::LoginPage;
use Test::Most;
use base 'Test::Class::Selenium::TestCases::BaseTest';

=head1 NAME

TestMarkets - This Test Class verifies markets and submarkets

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TESTCASES

=cut

{

BEGIN {$ENV{DIE_ON_FAIL} = 1}

=head3 test_new_york_submarket

Verify New York is still a submarket

Test Steps:

=over

=item 1. Verify in tblsubmarket that New York exists, where submarket_nm = 'New York'

=back

Expected Result:

terminate_dm is populated

=cut

sub test_new_york_submarket: Test(no_plan)
{
	my($self) = @_;	

	my $newyork_submarket_nm = 'New York';
	my $new_york_city_market_nm = 'New York City';
	my $new_york_state_cd = 'NY';
	my $new_york_city_market_nb = "";
	my $market_nb = "";
	my $terminate_dm = "";

	my $marketsdao = Test::Class::Selenium::DataAccessObjects::MarketsDao->new($self->{database}, $self->{db_username}, $self->{db_password});

	$new_york_city_market_nb = $marketsdao->get_market_nb_by_market_nm($new_york_city_market_nm);

	$market_nb = $marketsdao->get_market_nb_by_submarket_nm_and_state_cd($newyork_submarket_nm, $new_york_state_cd);
	ok($market_nb eq $new_york_city_market_nb, 'Verify market_nb for New York is equal to NYC\'s market_nb');	
	$terminate_dm = $marketsdao->get_terminate_dm_by_submarket_nm($newyork_submarket_nm);
	ok($terminate_dm eq "", 'Verify terminate_dm for New York is null');	

}

=head3 test_new_york_city_terminated_markets

Verify eliminated markets

Test Steps:

=over

=item 1. Verify in tblmarket that terminate_dm is populated where market_nm = 'Brooklyn'

=item 2. Verify in tblmarket that terminate_dm is populated where market_nm = 'Manhattan'

=item 3. Verify in tblmarket that terminate_dm is populated where market_nm = 'Queens'

=item 4. Verify in tblmarket that terminate_dm is populated where market_nm = 'Staten Island'

=back

Expected Result:

terminate_dm is populated

=cut

sub test_new_york_city_terminated_markets: Test(no_plan)
{
	my($self) = @_;	

	my $brooklyn_market_nm = 'Brooklyn';
	my $manhattan_market_nm = 'Manhattan';
	my $queens_market_nm = 'Queens';
	my $staten_island_market_nm = 'Staten Island';
	my $terminate_dm = "";

	my $marketsdao = Test::Class::Selenium::DataAccessObjects::MarketsDao->new($self->{database}, $self->{db_username}, $self->{db_password});

	$terminate_dm = $marketsdao->get_terminate_dm_by_market_nm($brooklyn_market_nm);
	ok($terminate_dm ne "", 'Verify terminate_dm for Brooklyn is not null');	

	$terminate_dm = $marketsdao->get_terminate_dm_by_market_nm($manhattan_market_nm);
	ok($terminate_dm ne "", 'Verify terminate_dm for Manhattan is not null');

	$terminate_dm = $marketsdao->get_terminate_dm_by_market_nm($queens_market_nm);
	ok($terminate_dm ne "", 'Verify terminate_dm for Queens is not null');

	$terminate_dm = $marketsdao->get_terminate_dm_by_market_nm($staten_island_market_nm);
	ok($terminate_dm ne "", 'Verify terminate_dm for Staten Island is not null');

}

=head3 test_new_york_city_added_submarkets

Verify added new york submarket

Test Steps:

=over

=item 1. Verify in tblsubmarket that market_nb is equal to that of NYC where submarket_nm = 'Brooklyn'

=item 2. Verify in tblsubmarket that market_nb is equal to that of NYC where market_nm = 'Manhattan'

=item 3. Verify in tblsubmarket that market_nb is equal to that of NYC where market_nm = 'Queens'

=item 4. Verify in tblsubmarket that market_nb is equal to that of NYC where market_nm = 'Staten Island'

=back

Expected Result:

terminate_dm is populated

=cut

sub test_new_york_city_added_submarkets: Test(no_plan)
{
	my($self) = @_;	

	my $new_york_city_market_nm = 'New York City';
	my $new_york_state_cd = 'NY';
	my $new_york_city_market_nb = "";
	my $brooklyn_submarket_nm = 'Brooklyn';
	my $manhattan_submarket_nm = 'Manhattan';
	my $queens_submarket_nm = 'Queens';
	my $staten_island_submarket_nm = 'Staten Island';
	my $market_nb = "";
	my $terminate_dm = "";

	my $marketsdao = Test::Class::Selenium::DataAccessObjects::MarketsDao->new($self->{database}, $self->{db_username}, $self->{db_password});

	$new_york_city_market_nb = $marketsdao->get_market_nb_by_market_nm($new_york_city_market_nm);
	
	$market_nb = $marketsdao->get_market_nb_by_submarket_nm_and_state_cd($brooklyn_submarket_nm, $new_york_state_cd);
	ok($market_nb eq $new_york_city_market_nb, 'Verify market_nb for Brooklyn is equal to NYC\'s market_nb');	
	$terminate_dm = $marketsdao->get_terminate_dm_by_submarket_nm($brooklyn_submarket_nm);
	ok($terminate_dm eq "", 'Verify terminate_dm for Brookln is null');	

	$market_nb = $marketsdao->get_market_nb_by_submarket_nm_and_state_cd($manhattan_submarket_nm, $new_york_state_cd);
	ok($market_nb eq $new_york_city_market_nb, 'Verify market_nb for Manhattan is equal to NYC\'s market_nb');	
	$terminate_dm = $marketsdao->get_terminate_dm_by_submarket_nm($manhattan_submarket_nm);
	ok($terminate_dm eq "", 'Verify terminate_dm for Manhattan is null');	

	$market_nb = $marketsdao->get_market_nb_by_submarket_nm_and_state_cd($queens_submarket_nm, $new_york_state_cd);
	ok($market_nb eq $new_york_city_market_nb, 'Verify market_nb for Queens is equal to NYC\'s market_nb');	
	$terminate_dm = $marketsdao->get_terminate_dm_by_submarket_nm($queens_submarket_nm);
	ok($terminate_dm eq "", 'Verify terminate_dm for Queens is null');	

	$market_nb = $marketsdao->get_market_nb_by_submarket_nm_and_state_cd($staten_island_submarket_nm, $new_york_state_cd);
	ok($market_nb eq $new_york_city_market_nb, 'Verify market_nb for Staten Island is equal to NYC\'s market_nb');	
	$terminate_dm = $marketsdao->get_terminate_dm_by_submarket_nm($staten_island_submarket_nm);
	ok($terminate_dm eq "", 'Verify terminate_dm for Staten Island is null');	
	
}

=head3 test_ny_markets_redirects

Verify the new york submarkets get redirected to the correct url.  (IB-7784)

Test Steps:


=over

"/rentals/new-york/brooklyn/brooklyn/"            "/rentals/new-york/new-york-city/brooklyn/"
"/rentals/new-york/staten-island/staten-island/"  "/rentals/new-york/new-york-city/staten-island/"
"/rentals/new-york/queens/jamaica/"               "/rentals/new-york/new-york-city/queens/"
"/rentals/new-york/the-bronx/Fordham"             "/rentals/new-york/new-york-city/bronx/"

These URLs were serving 404's, and should redirect as follows:

"/guest/new-york/brooklyn/brooklyn/"              "/guest/new-york/new-york-city/brooklyn/"
"/guest/new-york/staten-island/staten-island/"    "/guest/new-york/new-york-city/staten-island/"
"/guest/new-york/queens/woodside"                 "/guest/new-york/new-york-city/queens/"
"/guest/new-york/the-bronx/Melrose/"              "/guest/new-york/new-york-city/bronx/"

=back

Expected Result:

Urls get redirected properly

=cut

sub test_ny_markets_redirects: Test(no_plan)
{
	my($self) = @_;	

	my $old_rentals_brooklyn = '/rentals/new-york/brooklyn/brooklyn/';
	my $old_rentals_staten_island = '/rentals/new-york/staten-island/staten-island/';
	my $old_rentals_queens = '/rentals/new-york/queens/jamaica/';
	my $old_rentals_the_bronx = '/rentals/new-york/the-bronx/Fordham';	
	my $new_rentals_brooklyn = '/rentals/new-york/new-york-city/brooklyn/';
	my $new_rentals_staten_island = '/rentals/new-york/new-york-city/staten-island/';
	my $new_rentals_queens = '/rentals/new-york/new-york-city/queens/';
	my $new_rentals_the_bronx = '/rentals/new-york/new-york-city/bronx/';

	my $old_guest_brooklyn = '/guest/new-york/brooklyn/brooklyn/';
	my $old_guest_staten_island = '/guest/new-york/staten-island/staten-island/';
	my $old_guest_queens = '/guest/new-york/queens/jamaica/';
	my $old_guest_the_bronx = '/guest/new-york/the-bronx/Fordham';	
	my $new_guest_brooklyn = '/guest/new-york/new-york-city/brooklyn/';
	my $new_guest_staten_island = '/guest/new-york/new-york-city/staten-island/';
	my $new_guest_queens = '/guest/new-york/new-york-city/queens/';
	my $new_guest_the_bronx = '/guest/new-york/new-york-city/bronx/';
	
	my $loginpage = Test::Class::Selenium::PageObjects::LoginPage->new($self);
	
	#"/rentals/new-york/brooklyn/brooklyn/" -> "/rentals/new-york/new-york-city/brooklyn/"	
	$loginpage->open_page($old_rentals_brooklyn );	
	ok($loginpage->get_location() eq $self->{test_url}.$new_rentals_brooklyn, 'Verify redirect '.$old_rentals_brooklyn.' -> '.$new_rentals_brooklyn);	
	#"/rentals/new-york/staten-island/staten-island/" -> "/rentals/new-york/new-york-city/staten-island/"
	$loginpage->open_page($old_rentals_staten_island);
	ok($loginpage->get_location() eq $self->{test_url}.$new_rentals_staten_island, 'Verify redirect '.$old_rentals_staten_island.' -> '.$new_rentals_brooklyn);	
	#"/rentals/new-york/queens/jamaica/" -> "/rentals/new-york/new-york-city/queens/"
	$loginpage->open_page($old_rentals_queens);
	ok($loginpage->get_location() eq $self->{test_url}.$new_rentals_queens, 'Verify redirect '.$old_rentals_queens.' -> '.$new_rentals_brooklyn);	
	#"/rentals/new-york/the-bronx/Fordham" -> "/rentals/new-york/new-york-city/bronx/"
	$loginpage->open_page($old_rentals_the_bronx);
	ok($loginpage->get_location() eq $self->{test_url}.$new_rentals_the_bronx, 'Verify redirect '.$old_rentals_the_bronx.' -> '.$new_rentals_brooklyn);	
		
	#"/guest/new-york/brooklyn/brooklyn/" -> "/guest/new-york/new-york-city/brooklyn/"	
	$loginpage->open_page($old_guest_brooklyn );	
	ok($loginpage->get_location() eq $self->{test_url}.$new_guest_brooklyn, 'Verify redirect '.$old_guest_brooklyn.' -> '.$new_guest_brooklyn);	
	#"/guest/new-york/staten-island/staten-island/" -> "/guest/new-york/new-york-city/staten-island/"
	$loginpage->open_page($old_guest_staten_island);
	ok($loginpage->get_location() eq $self->{test_url}.$new_guest_staten_island, 'Verify redirect '.$old_guest_staten_island.' -> '.$new_guest_brooklyn);	
	#"/guest/new-york/queens/jamaica/" -> "/guest/new-york/new-york-city/queens/"
	$loginpage->open_page($old_guest_queens);
	ok($loginpage->get_location() eq $self->{test_url}.$new_guest_queens, 'Verify redirect '.$old_guest_queens.' -> '.$new_guest_brooklyn);	
	#"/guest/new-york/the-bronx/Fordham" -> "/guest/new-york/new-york-city/bronx/"
	$loginpage->open_page($old_guest_the_bronx);
	ok($loginpage->get_location() eq $self->{test_url}.$new_guest_the_bronx, 'Verify redirect '.$old_guest_the_bronx.' -> '.$new_guest_brooklyn);	

}

1;

}

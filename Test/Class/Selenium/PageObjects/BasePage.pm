package Test::Class::Selenium::PageObjects::BasePage;

use strict;
use warnings;
use Time::HiRes qw(sleep);
use Test::WWW::Selenium;
use Test::Most;
use Test::Exception;

use constant {
	TFIELD_EMAIL => "si_email",
	TFIELD_PASSWORD => "si_password",
	LINK_SIGNIN => "linktoplink_signin",
	BUTTON_SIGNIN => "css=button.css_button.clearfix",
	LINK_SIGNOUT => "Sign Out",
	PAGE_TIMEOUT => "120000",
	LINK_SEARCHTAB => "link=Search Properties"
};

=head1 NAME

BasePage

=head1 SYNOPSIS

BasetTest Package

=head1 DESCRIPTION

Contains common page methods.

=cut

{

=item -E<gt>new( %args )

Constructs a new C<pageobjects> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=over

=item $BasePage-E<gt>is_text_present($password)

Checks if Text is present

=cut

sub is_text_present{
	my ( $self, $text ) = @_;

	$self->try_command($self->{testdriver}->{browser}->is_text_present($text), "is_text_present", $text);
}

=item $BasePage-E<gt>is_page_title_present($password)

Checks if Title is present

=cut

sub is_page_title_present{
	my ( $self, $title ) = @_;

	my $actual_title = $self->{testdriver}->{browser}->get_title();
	return ($self->try_command($title eq $actual_title, "is_page_title_present", $title));
	
}

=item $BasePage-E<gt>sign_out($username, $password, $page)

$page is optional, and is for defining start page:  'Search Properties', 'Moving Center', etc.

Signs in.

=cut

sub sign_in	{
	my ( $self, $username, $password, $page ) = @_;

	if (!defined $page ){
		$page = "";
	}
		
	$self->open($page."/?toggle_sign_in_box=1");
	$self->type(TFIELD_EMAIL, $username);
	$self->click(BUTTON_SIGNIN);
	
	if (defined $password ){
		$self->wait_for_text_present('Rent.com Password', '120000');
		$self->pause('5000');
		$self->type(TFIELD_PASSWORD, $password);
		$self->click(BUTTON_SIGNIN);
	}

	$self->certificate_error_handler();
		
	print ("\n#logging in as: ".$username."\\".$password."\n");
	
}

=item $BasePage-E<gt>sign_out()

Signs out.

=cut

sub sign_out	{
	my ( $self ) = @_;
	
	$self->pause("5000");   
	$self->click("link=".LINK_SIGNOUT);	
	$self->wait_for_page_to_load(PAGE_TIMEOUT);   
	$self->pause("5000");   
}

=item $BasePage-E<gt>open_page($relative_path)

Open url.

Parameter in:  '/rentals/473829'

=cut

sub open_page {
	my ( $self,$url ) = @_;

	$self->try_command($self->open($url), "open_page", $url);
	#$self->{testdriver}->{browser}->wait_for_page_to_load("30000");   
}

=over

=item $BasePage-E<gt>certificate_error_handler($sel)

Clicks the "Continue to this website..." link on IE browser when a certificate error page displays

=cut

sub certificate_error_handler() {    	
	my ($self) = @_;
	
	#pause for 5 seconds
	$self->{testdriver}->{browser}->pause("5000");
	
	# Case when the IE certificate error page displays
	if ($self->{testdriver}->{browser}->is_text_present("Continue to this website (not recommended).")) {
		$self->{testdriver}->{browser}->click("link=Continue to this website (not recommended).");
		$self->{testdriver}->{browser}->wait_for_page_to_load(PAGE_TIMEOUT);
	}
	
}

=over

=item $BasePage-E<gt>type($sel)

Sets the value of an input field, as though you typed it in. Can also be used to set the value of combo boxes, check boxes, etc. In these cases,value should be the value of the option selected, not the visible text.

=cut

sub type{
	my ( $self, $element_locator, $text ) = @_;
	
	$self->{testdriver}->{browser}->fire_event($element_locator, "focus");
	$self->try_command($self->{testdriver}->{browser}->type_ok($element_locator, $text), "type", $element_locator);
	$self->{testdriver}->{browser}->fire_event($element_locator, "blur");	
	$self->{testdriver}->{browser}->focus($element_locator);	
}

=over

=item $BasePage-E<gt>click($sel)

Clicks on a link, button, checkbox or radio button. If the click actioncauses a new page to load (like a link usually does), callwaitForPageToLoad.

=cut

sub click{
	my ( $self, $element_locator) = @_;
	
	$self->try_command($self->{testdriver}->{browser}->mouse_down_ok($element_locator), "click_mouse_down", $element_locator);
	$self->try_command($self->{testdriver}->{browser}->click_ok($element_locator), "click", $element_locator);

}

=over

=item $BasePage-E<gt>select($sel)

Select an option from a drop-down using an option locator. Option locators provide different ways of specifying options of an HTMLSelect element

=cut

sub select{
	my ( $self, $element_locator, $option) = @_;
	
	$self->{testdriver}->{browser}->mouse_down($element_locator);
	$self->{testdriver}->{browser}->select_ok($element_locator, $option);	
	$self->{testdriver}->{browser}->mouse_up($element_locator);
			
}

=over

=item $BasePage-E<gt>wait_for_page_to_load($sel)

Waits for a new page to load.

=cut

sub wait_for_page_to_load{
	my ( $self, $millisecs) = @_;

	$self->{testdriver}->{browser}->wait_for_page_to_load($millisecs);

}

=over

=item $BasePage-E<gt>open($sel)

Opens an URL in the test frame.

=cut

sub open{
	my ( $self, $url) = @_;

	$self->{testdriver}->{browser}->open_ok($url); 
	#make sure page is loaded
	$self->{testdriver}->{browser}->wait_for_text_present("rent.com", "120000");
	 	
}

=over

=item $BasePage-E<gt>is_element_present($sel)

Verifies that the specified element is somewhere on the page.

=cut

sub is_element_present{
	my ( $self, $locator) = @_;

	$self->{testdriver}->{browser}->is_element_present($locator);  	
}

=over

=item -E<gt>set_all_completed_leases_as_incomplete($sel)

Set all completed leases to incomplete

=cut

sub set_all_completed_leases_as_incomplete {
	my ( $self) = @_;
		
	$self->{testdriver}->{browser}->open('/inside/qa/make-leases-incomplete/');

}

=item $loginpage-E<gt>click_manage_your_property()

Clicks manager your property

=cut

sub click_manage_your_property {
	my ( $self) = @_;
	
	$self->{testdriver}->{browser}->click("link=Manage Your Property");
	$self->{testdriver}->{browser}->wait_for_page_to_load(PAGE_TIMEOUT);
	$self->{testdriver}->{browser}->pause("5000");
}

=item $loginpage-E<gt>click_manage_your_property()

Clicks list your property

=cut

sub click_list_your_property {
	my ( $self) = @_;
	
	$self->{testdriver}->{browser}->click("link=List Your Property");
	$self->{testdriver}->{browser}->wait_for_page_to_load(PAGE_TIMEOUT);

}

=item $loginpage-E<gt>click_manage_your_property()

Clicks list your property

=cut

sub click_search_properties {
	my ( $self) = @_;
	
	$self->{testdriver}->{browser}->click(LINK_SEARCHTAB);
	$self->{testdriver}->{browser}->wait_for_page_to_load(PAGE_TIMEOUT);

}


=item $loginpage-E<gt>get_time_out()

Accessor method to get page_time data memeber

=cut

sub get_page_timeout {
	
	return PAGE_TIMEOUT;
}

=item $loginpage-E<gt>get_page_text()

Method to get body text on current page

=cut

sub get_page_text() 
{
	my ( $self ) = @_;
	my $pagetext;
	
	$pagetext = $self->{testdriver}->{browser}->get_body_text();
	
	return ( $pagetext );
}

=item $page-E<gt>get_location()

Method to get url

=cut

sub get_location()
{
	my ( $self ) = @_;
	my $url;
	
	$url = $self->{testdriver}->{browser}->get_location();
	
	return ( $url );
}

=over

=item $BasePage-E<gt>pause(milliseconds)

pause for n amount of milliseconds

=cut

sub pause() {    	
	my ($self, $milliseconds) = @_;
	
	#pause for n  milliseconds
	$self->{testdriver}->{browser}->pause("$milliseconds");
	
}

=item $BasePage-E<gt>get_text_value()

Method to get text from form (or other) elements

=cut

sub get_text_value() 
{
	my ( $self, $element_locator ) = @_;
	
	$self->{testdriver}->{browser}->get_value($element_locator);
}

sub get_text()
{
	my ( $self, $element_locator ) = @_;
	
	$self->{testdriver}->{browser}->get_text( $element_locator );
}

sub get_html_source()
{
	my ( $self, $xpath ) = @_;
	
	my $html = $self->{testdriver}->{browser}->get_html_source();

	return ($html)
}


sub select_frame()
{
	my ( $self, $element_locator ) = @_;
	
	$self->{testdriver}->{browser}->select_frame( $element_locator );
}

sub select_window()
{
	my ( $self, $window_id ) = @_;
	
	$self->{testdriver}->{browser}->select_window ( $window_id );
}

sub get_xpath_count()
{
	my ( $self, $xpath ) = @_;
	
	$self->{testdriver}->{browser}->get_xpath_count ( $xpath );
}

=over

=item $BasePage-E<gt>try_command($path)

Try automated driver command and check results, if fail take screenshot

=cut

sub try_command(){

	my ( $self, $result, $type, $testcase ) = @_;
			
	if (not $result){
		 $ENV{tc_stat} = 'Failed';
		 $ENV{tc_comment}=$ENV{tc_comment}."\n".$type.' - '.$testcase;
		$self->screen_capture($type, $testcase);
	}
	
	return $result;
	
}

=over

=item $BasePage-E<gt>screen_capture($test_type)

Capture screen

=cut

sub screen_capture {
    my ( $self, $test_type, $testcase ) = @_;
   
	my $data = Test::Class::Selenium::Util::GenerateData->new();
    my $new_filename = $data->get_todays_date_yyyymmddhhmmss();
    my $path = $self->{testdriver}->{screenshot};
    
    if($self->{testdriver}->{browser_type} ne "*iexplore")
    {
    	#this is a ff function
    	$self->{testdriver}->{browser}->capture_entire_page_screenshot($path."".$new_filename."_".$test_type."_".$testcase.".png");
	}
}

=over

=item $BasePage-E<gt>clear_cookies()

Delete cookies and refresh browser.

=cut

sub delete_all_visible_cookies{
    my ( $self ) = @_;

    $self->{testdriver}->{browser}->delete_all_visible_cookies();
    $self->{testdriver}->{browser}->refresh();
	$self->{testdriver}->{browser}->wait_for_page_to_load(PAGE_TIMEOUT);
}

=over

=item $BasePage-E<gt>wait_for_element_present()

Wait for element to be present

=cut
sub wait_for_element_present {
    my ( $self, $locator, $timeout ) = @_;

    $self->{testdriver}->{browser}->wait_for_element_present( $locator, $timeout );

}

=over

=item $BasePage-E<gt>wait_for_text_present()

Waits until $text is present in the html source

=cut
sub wait_for_text_present {
    my ( $self, $text, $timeout ) = @_;

    $self->try_command($self->{testdriver}->{browser}->wait_for_text_present( $text, $timeout ));

}

=over

=item $BasePage-E<gt>key_press_native()

$key_sequence is Either be a string("\" followed by the numeric keycode of the key to be pressed, normally the ASCII value of that key), or a single character. For example: "w", "\119".
=cut
sub key_press {
    my ( $self, $locator, $key_sequence ) = @_;

    $self->{testdriver}->{browser}->key_press($locator, $key_sequence);

}

=over

=item $BasePage-E<gt>key_press_native()

Simulates a user pressing and releasing a key by sending a native operating system keystroke.This function uses the java.awt.Robot class to send a keystroke; this more accurately simulates typinga key on the keyboard.

=cut
sub key_press_native {
    my ( $self, $keycode ) = @_;

    $self->{testdriver}->{browser}->key_press_native($keycode);

}

=over

=item $BasePage-E<gt>refresh()

Simulates a user clicking refresh on their browser
=cut
sub refresh {
    my ( $self ) = @_;

    $self->{testdriver}->{browser}->refresh();

}

sub get_all_links {
    my ( $self ) = @_;

    $self->{testdriver}->{browser}->get_all_links();

}

sub is_visible {
    my ( $self,  $locator ) = @_;

    $self->{testdriver}->{browser}->is_visible($locator);


}

sub shut_down_selenium_server(){
	
	 my ( $self) = @_;
	 $self->{testdriver}->{browser}->shut_down_selenium_server();
}

sub key_press_up_arrow {
    my ( $self,  $locator ) = @_;
    $self->{testdriver}->{browser}->key_down($locator, "\\38");
    $self->{testdriver}->{browser}->key_up($locator, "\\38");
}

1;

}

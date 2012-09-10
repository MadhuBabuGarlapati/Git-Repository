package Test::Class::Selenium::PageObjects::PropertyDescriptionPage;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::BasePage;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {
	#BUTTON_HOTLEADLINK => "hotlead_link",
	LINK_CHECKAVAILABILITY => "Check Availability",
	FRAME_FORMBOX => "formbox",
	TFIELD_FNAME => "first_name",
	TFIELD_LNAME => "last_name",
	TFIELD_PHONE => "phone",
	TAREA_MESSAGE => "message",
	BUTTON_SEND => "//img[\@alt='Send']",
	TFIELD_DATESTART => "date_start",
	
	BUTTON_CLOSEFORM => "//img[\@alt='Close']",

	LINK_CLAIMREWARD => "Claim reward now!",
	LINK_SENDTOFRIEND => "//a[\@id='sendto_friend']",
	TFIELD_EMAIL => "friend_email",
	LINK_ENLARGEIMAGE => "//a[\@id='enlarge_link']",
	BUTTON_MEDIAVIEWER_NEXT => "//a[\@id='pic_next']/img",
	BUTTON_MEDIAVIEWER_PREVIOUS => "//a[\@id='pic_prev']/img",
	BUTTON_MEDIAVIEWER_FLOORPLANS => "//a[\@id='floorplans']"
};

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

=head2 METHODS

=over

=cut

{
	
=item $loginpage= pageobjects::PropertyDescriptionPage-E<gt>new( %args )

Constructs a new C<pageobjects::PropertyDescriptionPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

sub submit_hotlead {
    my ($self, $fname, $lname, $date) = @_;

	$self->click_check_availability();
	$self->fill_lead_form_box_info($fname, $lname, $date);	
	$self->click_send();
	$self->close_form_box();
}

sub click_check_availability {
    my ($self) = @_;

	$self->click("link=".LINK_CHECKAVAILABILITY);
	$self->pause("10000"); #give it 10 seconds, getelementby id, i think causes crash
	#$self->wait_for_condition("selenium.browserbot.getCurrentWindow().frames['formbox'].document.getElementById('".TAREA_MESSAGE."')!= null", "60000");
	$self->select_frame(FRAME_FORMBOX);
}

sub fill_lead_form_box_info(){
    my ($self, $fname, $lname, $phone, $date) = @_;

	$self->type(TFIELD_FNAME, $fname);
	$self->type(TFIELD_LNAME, $lname);

	#$self->click("link=Choose date");
	$self->type(TFIELD_DATESTART, $date);

	$self->type(TFIELD_PHONE,$phone);
	$self->type(TAREA_MESSAGE, "more details please");	
}

sub click_send(){
    my ($self) = @_;

	$self->pause("5000");	
	$self->click(BUTTON_SEND);
	$self->pause("20000");	
	
}

sub close_form_box{
	my ($self) = @_;

	#IE vs FF?	
	$self->click(BUTTON_CLOSEFORM);
	#FF
	$self->select_frame("relative=top");	
	#IE
	#$self->select_window("name=null");

}

sub click_claim_reward{
    my ($self) = @_;
    
	print "# click on claim reward. \n";	
	$self->click("link=".LINK_CLAIMREWARD);
	$self->wait_for_page_to_load($self->get_page_timeout());	
	print "# clicked claim reward. \n";	

}

=item $propertydescriptionpage-E<gt>submit_password()

Enters password as 'qatest11'

=cut

sub submit_password(){
	my ( $self, $password ) = @_;	
	
	my $message_box = "name=message_box_ifr";
	if ($self->is_element_present($message_box)){
		$self->select_frame($message_box);
		
		if (!defined $password ){
			$password =  "qatest11";
		}
		
		$self->type("password", $password);	
		#print '#\n password: '.$password.'\n ';	
		$self->click("//input[\@type='image']");
		#pause for 45 seconds	
		$self->pause("45000");	
		$self->select_window("");
	}
	else {
		print "#no password entered \n";
	}
	
}

=item $propertydescriptionpage-E<gt>goto_property()

Goto a propety page

=cut

sub goto_property(){
	my ( $self, $property_id ) = @_;	

	print "#Goto property: ".$property_id."\n";
	$self->open("/rentals/".$property_id."/
	");
	$self->pause("30000");

	#$self->wait_for_page_to_load("30000");
}

=item $propertydescriptionpage-E<gt>click_send_to_a_friend()

Click on "Send to a Friend" link

=cut

sub click_send_to_a_friend(){
	my ( $self ) = @_;	

	$self->click(LINK_SENDTOFRIEND);
	$self->pause("10000");
	$self->select_frame(FRAME_FORMBOX);
}

=item $propertydescriptionpage-E<gt>fill_sendtofriend_form_box_info()

Click on "Send to a Friend" link

=cut

sub fill_sendtofriend_form_box_info(){
    my ($self, $fname, $lname, $email) = @_;

	$self->type(TFIELD_FNAME, $fname);
	$self->type(TFIELD_LNAME, $lname);
	$self->type(TFIELD_EMAIL, $email);

	$self->type(TAREA_MESSAGE, "Check out this property!");	
}

=item $propertydescriptionpage-E<gt>click_enlarge_image()

Click on "Enlarge Image" link

=cut

sub click_enlarge_image(){
	my ( $self ) = @_;	

	$self->click(LINK_ENLARGEIMAGE);
	$self->pause("10000");
	$self->select_frame(FRAME_FORMBOX);
}

=item $propertydescriptionpage-E<gt>click_mediaviewer_next()

Click on "Next" link on Media Viewer

=cut

sub click_mediaviewer_next(){
	my ( $self ) = @_;	

	$self->click(BUTTON_MEDIAVIEWER_NEXT);
	$self->pause("10000");
}

=item $propertydescriptionpage-E<gt>click_mediaviewer_previous()

Click on "Previous" link on Media Viewer

=cut

sub click_mediaviewer_previous(){
	my ( $self ) = @_;	

	$self->click(BUTTON_MEDIAVIEWER_PREVIOUS);
	$self->pause("10000");
}

=item $propertydescriptionpage-E<gt>click_mediaviewer_floorplans()

Click on "Floorplans" link on Media Viewer

=cut

sub click_mediaviewer_floorplans(){
	my ( $self ) = @_;	

	$self->click(BUTTON_MEDIAVIEWER_FLOORPLANS);
	$self->pause("10000");
}

1;

}
package Test::Class::Selenium::PageObjects::PLT::AddPhotosPage;

use strict;
use warnings;
use base 'Test::Class::Selenium::PageObjects::BasePage';

use constant {

	BUTTON_UPLOADPROPERTYIMGS => "css=div.upload_button > a > img",
	BUTTON_UPLOADIMAGE => "name=save_goto_media",
	TFIELD_IMAGEBOXONE => "name=medianew0_media_ph"
	
};

=head1 NAME

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item $landingpage= pageobjects::AddPhotosPage-E<gt>new( %args )

Constructs a new C<pageobjects::AddPhotosPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

sub click_upload_property_images {
    my ( $self ) = @_;
   
   	$self->click(BUTTON_UPLOADPROPERTYIMGS);  
	$self->wait_for_text_present("Add Images");   
};

sub upload_image {
    my ( $self, $filepath ) = @_;
   
	#$self->{selenium}->{browser}->wait_for_element_present(BUTTON_PPL, "30000");
	$self->type(TFIELD_IMAGEBOXONE, $filepath); 
	$self->click(BUTTON_UPLOADIMAGE);  
	$self->wait_for_page_to_load($self->get_page_timeout());   
};

1

}
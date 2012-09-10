package Test::Class::Selenium::PageObjects::CSTool::NewContentPage;

use strict;
use warnings;
use Test::Class::Selenium::PageObjects::CSTool::CSToolBasePage;
use base 'Test::Class::Selenium::PageObjects::CSTool::CSToolBasePage';

use constant {

	TFIELD_PROPERTYID => "property_id",
	BUTTON_SUBMIT => "action",
	BUTTON_GO => "//input[\@value='Go']",
	
	RBUTTON_PREFFIX => "terminate_xt_",
	RBUTTON_APPROVED_POSTFIX => "_approved",
	RBUTTON_INAPPROPRIATE_POSTFIX => "_inappropriate",
	RBUTTON_FAIRHOUSING_POSTFIX => "_fair_housing",
	RBUTTON_POORQUALITY_POSTFIX => "_poor_quality",

};

=head1 NAME

NewContentPage

=head1 SYNOPSIS

Test::Class::Selenium::PageObjects::CSTool::NewContentPage

=head1 DESCRIPTION

This class encapsulates the functionality associated with the CSTool NewContent tab.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	
	
=item Test::Class::Selenium::PageObjects::CSTool::NewContentPage-E<gt>new( %args )

Constructs a new C<Test::Class::Selenium::PageObjects::CSTool::NewContentPage> object.

=cut

sub new {
    my $class = shift;
    my $self = {
    	testdriver => shift
    };

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}	

=item $NewContentPage-E<gt>type_property_id($property_id)

Enter property id information

=cut	

sub type_property_id {
    my ( $self, $property_id ) = @_;

	$self->type(TFIELD_PROPERTYID, $property_id);
};

=item $NewContentPage-E<gt>click_radio_button_approved_img($property_id)

Click approved radio button for image, we pass in property_id so we know which img on the page to approve

=cut	

sub click_radio_button_approved_img {
    my ( $self, $property_id ) = @_;

	my $newcontentdao = Test::Class::Selenium::DataAccessObjects::NewContentDao->new($self->{testdriver}->{database}, $self->{testdriver}->{db_username}, $self->{testdriver}->{db_password});
	my $content_id = "";
	
	$content_id = $newcontentdao->get_newcontent_id_by_object_id($property_id);
	
	$self->click(RBUTTON_PREFFIX.$content_id.RBUTTON_APPROVED_POSTFIX);

};

=item $NewContentPage-E<gt>click_go()

Click go

=cut	

sub click_go{
    my ( $self ) = @_;

	$self->click(BUTTON_GO);
	$self->wait_for_page_to_load($self->get_page_timeout()); 

};


=item $NewContentPage-E<gt>click_submit()

Click submit

=cut	

sub click_submit{
    my ( $self ) = @_;

	$self->click(BUTTON_SUBMIT);
	$self->wait_for_page_to_load($self->get_page_timeout()); 

};

1;

}
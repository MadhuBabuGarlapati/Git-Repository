package Test::Class::Selenium::DataAccessObjects::PPLDao;

use strict;
use warnings;
use Test::Class::Selenium::DataAccessObjects::BaseDao;

use base 'Test::Class::Selenium::DataAccessObjects::BaseDao';


=head1 NAME

LandingPage

=head1 SYNOPSIS

dao::PPLDao Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with PPL data access objects.

=cut

=head2 METHODS

The following methods are available:

=over

=cut

{	

=item 

=cut

sub new {
    my $class = shift;
    my $self = {
		_database => shift,
        _db_username => shift,
        _db_password => shift,
    };
 
    bless $self, $class or die "Can't bless $class: $!";

    return $self; 
}
=head2 find_property_id_by_email()

Returns the news created property from the email provided.

=cut

sub get_most_recent_property_id_from_email {

    my ( $self, $email ) = @_;
    
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $property_id = $db->selectrow_array(
		"SELECT property_id from (
			SELECT property_id, create_dm
			FROM tblperson_property
			WHERE person_id IN
			(
		 		SELECT person_id
		 		FROM tblperson
		 		WHERE TRIM(LOWER(person_nm)) = TRIM(LOWER('".$email."'))
			)
			ORDER BY create_dm DESC	
		)
		WHERE ROWNUM <= 1"
	);
	
	print "\n#Property id:  ".$property_id."\n";
	
	$db->disconnect;
		
	return $property_id;
}

=head2 get_terminate_xt_from_property_id()

Return terminate_xt status of a property

=cut

sub get_terminate_xt_from_property_id {

    my ( $self, $property_id) = @_;
    
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $terminate_xt = $db->selectrow_array(
		"SELECT TERMINATE_XT 
		FROM tblproperty 
		WHERE property_id = ".$property_id
	);
	
	print "\n#terminate_xt:  ".$terminate_xt."\n";
	
	$db->disconnect;
		
	return $terminate_xt;
}

=head2 get_value_xt_from_property_id_and_note_nm()

Return value_xt from a property

=cut

sub get_value_xt_from_property_id_and_note_nm {

    my ( $self, $property_id, $note_nm) = @_;
    
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $value_xt = $db->selectrow_array(
		"SELECT value_xt 
		FROM tblnote 
		WHERE note_nm = '".$note_nm."' 
		AND lessor_id = ".$property_id
	);
	
	print "\n#value_xt:  ".$value_xt."\n";
	
	$db->disconnect;
		
	return $value_xt;
}

1;

}
package Test::Class::Selenium::DataAccessObjects::NewContentDao;

use strict;
use warnings;
use Test::Class::Selenium::DataAccessObjects::BaseDao;

use base 'Test::Class::Selenium::DataAccessObjects::BaseDao';


=head1 NAME

NewContentDao

=head1 SYNOPSIS

dao::NewContentDao Package

=head1 DESCRIPTION

This class encapsulates the functionality associated with the newcontent data access objects.
New content includes all this relevent that require CS approval.  ie. imgs, floorplans, etc.

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

=head2 get_terminate_xt_by_object_id($object_id)

Return terminate_xt by object_id

=cut

sub get_terminate_xt_by_object_id {
	my ( $self, $object_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $terminate_xt = $db->selectrow_array(qq{
		SELECT terminate_xt 
		FROM tblnewcontent 
		WHERE object_id = $object_id
		AND rownum 	<= 1 
		ORDER BY update_dm DESC
		
	});

	print "\n#terminate_xt:  ".$terminate_xt."\n";

	$db->disconnect();

	return $terminate_xt;
}

=head2 get_approved_fg_by_object_id()

Return approved_fg by object_id

=cut

sub get_approved_fg_by_object_id {
	my ( $self, $object_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $approved_fg = $db->selectrow_array(qq{
		SELECT approved_fg
		FROM tblnewcontent 
		WHERE object_id = $object_id
		AND rownum 	<= 1 
		ORDER BY update_dm DESC
		
	});

	print "\n#approved_fg:  ".$approved_fg."\n";

	$db->disconnect();

	return $approved_fg;
}

=head2 get_newcontent_id_by_object_id()

Return newcontent_id of the most recently created object_id

=cut

sub get_newcontent_id_by_object_id {
	my ( $self, $object_id ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $newcontent_id = $db->selectrow_array(qq{
	SELECT newcontent_id
	FROM(
		SELECT newcontent_id 
		FROM tblnewcontent 
		WHERE object_id = $object_id
		ORDER BY update_dm DESC
    	)
	WHERE rownum <= 1

	});

	print "\n#newcontent_id:  ".$newcontent_id."\n";

	$db->disconnect();

	return $newcontent_id;
}

=head2 get_most_recent_unapproved_img_for_a_plt_property()

Return object_id the most recent unapproved img for a plt property in pre-reg

=cut

sub get_most_recent_unapproved_img_for_a_plt_property {
	my ( $self ) = @_;
	
	my $db;

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	my $property_id = $db->selectrow_array(qq{
		SELECT property_id
		FROM(
			SELECT tblproperty.property_id 
			FROM tblproperty, tblnewcontent
			WHERE tblproperty.property_id = tblnewcontent.object_id 
			AND tblnewcontent.object_tp = 'Property' 
			AND tblnewcontent.terminate_xt is null
			AND tblproperty.terminate_xt = 'Pre-Registered (Not yet Activated)' 
			AND tblproperty.businessmodel_tp = 'plt'
			ORDER BY tblproperty.property_id DESC
		    )
		WHERE rownum <= 1	
	});

	print "\n#$property_id most_recent_unapproved_img_for_a_plt_property:  ".$property_id."\n";

	$db->disconnect();

	return $property_id;
}


1;

}
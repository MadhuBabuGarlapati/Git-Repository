package Test::Class::Selenium::DataAccessObjects::MarketsDao;

use strict;
use warnings;
use Test::Class::Selenium::DataAccessObjects::BaseDao;

use base 'Test::Class::Selenium::DataAccessObjects::BaseDao';


=head1 NAME

MarketsDao

=head1 SYNOPSIS


=head1 DESCRIPTION

This class encapsulates the functionality associated with market, submarket, and neighborhood objects.

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

=head2 get_terminate_dm_by_market_nm

Return terminate_dm by market_nm

=cut

sub get_terminate_dm_by_market_nm {
	my ( $self, $market_nm ) = @_;
	
	my $db;
	my $terminate_dm = "";

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$terminate_dm = $db->selectrow_array(qq{
		SELECT terminate_dm 
		FROM tblmarket 
		WHERE market_nm = '$market_nm'
		AND rownum 	<= 1 
		ORDER BY update_dm DESC
		
	});
	
	if ( ! defined($terminate_dm)) {
		$terminate_dm = "";
	}

	print "\n#terminate_dm:  ".$terminate_dm."\n";

	$db->disconnect();

	return $terminate_dm;
}

=head2 get_terminate_dm_by_submarket_nm

Return terminate_dm by submarket_nm

=cut

sub get_terminate_dm_by_submarket_nm {
	my ( $self, $submarket_nm ) = @_;
	
	my $db;
	my $terminate_dm = "";

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$terminate_dm = $db->selectrow_array(qq{
		SELECT terminate_dm 
		FROM tblsubmarket 
		WHERE submarket_nm = '$submarket_nm'
		AND rownum 	<= 1 
		ORDER BY update_dm DESC
		
	});

	if ( ! defined($terminate_dm)) {
		$terminate_dm = "";
	}
	
	print "\n#terminate_dm:  ".$terminate_dm."\n";

	$db->disconnect();

	return $terminate_dm;
}


=head2 get_market_nb_by_market_nm

Return market_nb by market_nm

=cut

sub get_market_nb_by_market_nm {
	my ( $self, $market_nm ) = @_;
	
	my $db;
	my $market_nb = "";

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$market_nb = $db->selectrow_array(qq{
		SELECT market_nb 
		FROM tblmarket 
		WHERE market_nm = '$market_nm'
		AND rownum 	<= 1 
		ORDER BY update_dm DESC
		
	});

	if ( ! defined($market_nb)) {
		$market_nb = "";
	}
	
	print "\n#market_nb:  ".$market_nb."\n";

	$db->disconnect();

	return $market_nb;
}


=head2 get_market_nb_by_submarket_nm_and_state_cd

Return market_nb by submarket_nm and state_cd

=cut

sub get_market_nb_by_submarket_nm_and_state_cd {
	my ( $self, $submarket_nm, $state_cd ) = @_;
	
	my $db;
	my $market_nb = "";

	$db = $self->open_db($self->{_database},$self->{_db_username}, $self->{_db_password});
	
	$market_nb = $db->selectrow_array(qq{
		SELECT market_nb 
		FROM tblsubmarket 
		WHERE submarket_nm = '$submarket_nm'
		AND state_cd = '$state_cd'
                AND rownum <= 1 
		ORDER BY update_dm DESC
		
	});

	if ( ! defined($market_nb)) {
		$market_nb = "";
	}
	
	print "\n#market_nb:  ".$market_nb."\n";

	$db->disconnect();

	return $market_nb;
}

1;

}

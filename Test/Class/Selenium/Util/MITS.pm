package Test::Class::Selenium::Util::MITS;

use strict;
use warnings;
use XML::Simple;

=head1 NAME

Test::Class::Selenium::Util::MITS

=head1 SYNOPSIS

MITS testing helpers

=head1 DESCRIPTION

Generate data for testcases

=cut


=item $data = Test::Class::Selenium::Util::MITS-E<gt>new( database, username, password )

Constructs a new C<Test::Class::Selenium::Util::MITS> object.

=cut

{

sub new {

    my $class = shift;
    my $self = {};

    bless $self, $class or die "Can't bless $class: $!";
    		
    return $self;
}

=head3 read_in_xml

Reads in an xml file.  This subroutine accepts an xmlfile.  And returns a reference to a data structure which contains the same data.

=cut
sub read_in_xml{
	my ( $self, $xmlfile ) = @_;
	
	my $xs = XML::Simple->new();
	
	my $ref = $xs->XMLin($xmlfile);
	
	return $ref;
}

=head3 run_upload_xml

Runs the upload-ftp-mits-xml script.  This subroutine accepts the company_id, xmlfile, and database where this script will run on.  Returns the output message.

=cut
sub run_upload_xml{
	my ( $self, $company_id,$xmlfile, $db) = @_;

        my $cmd = `\$WEBROOT/bin/upload-ftp-mits-xml --feedprovider $company_id --database $db --file $xmlfile --debug --qaemail`;

	return $cmd;
}

1;

}

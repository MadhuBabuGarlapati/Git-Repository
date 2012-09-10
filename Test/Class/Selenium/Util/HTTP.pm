package Test::Class::Selenium::Util::HTTP;

use strict;
use warnings;
use DBI;
use WWW::Mechanize;

=head1 NAME

Test::Class::Selenium::Util::HTTP

=head1 SYNOPSIS

HTTP utility class.

=head1 DESCRIPTION

This class is built upon WWW::Mechanize, it is used to fill the short comings of selenium.

=cut

my $mech;

=item $data = Test::Class::Selenium::Util::HTTP-E<gt>new()

Constructs a new C<Test::Class::Selenium::Util::HTTP> object.

=cut

{

sub new {

	my ($class) = @_;
	my $self = {};

	$mech = WWW::Mechanize->new();	

	bless $self, $class or die "Can't bless $class: $!";

	return $self;
}

=head2 get( $uri )

Gets a uri and returns the response

=cut

sub get {
	my ( $self, $uri ) =@_;

	return $mech->get($uri);
}

=head2 uri

Return current uri

=cut

sub uri{
	my ( $self ) =@_;

	return $mech->uri();
}

1;

}


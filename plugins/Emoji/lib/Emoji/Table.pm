package Emoji::Table;

use strict qw( vars subs );
use warnings;

our %Table = ();

sub get_name {
    my ( $self, $code ) = @_;
    my %table = %{*{$self . '::Table'}};
    return $table{$code};
}

1;

package Emoji::Tags;

use strict;
use warnings;

use URI;
use MT::ConfigMgr;
use File::Spec;

use Emoji::Table::TypeCast;

sub _hdlr_emoji {
    my ( $str, $arg, $ctx ) = @_;
    
    my $mode = lc $arg;

    if ( $mode eq 'pc' || $mode eq 'typecast' || $mode eq 'all' ) {
        $str = _hdlr_emoji_typecast( $str, 1, $ctx);
    } elsif ( $mode eq 'docomo' ) {
        # TODO
    } elsif ( $mode eq 'au' || $mode eq 'kddi' ) {
        # TODO
    } elsif ( $mode eq 'softbank' ) {
        # TODO
    }
    
    return $str;
}

sub _hdlr_emoji_typecast {
    my ( $str, $arg, $ctx ) = @_;
    return $str if $arg < 1;
    return _replace('TypeCast', $str);
}

sub _replace {
    my ( $m, $str ) = @_;

    my $module = 'Emoji::Table::'.$m;

    my $cfg = MT::ConfigMgr->instance;
    my $static_path = $cfg->StaticWebPath.'plugins/Emoji/';
    my $base_path = $static_path.'images/emoticons/';

    $str =~ s/((?:\G|>)[^<]*?)\[E:([\w\-]{0,16})\]/$1<img class=\"emoticon $2\" src="$base_path@{[ $module->get_name( $2 ) ]}.gif">/g;

    return $str;
}

1;

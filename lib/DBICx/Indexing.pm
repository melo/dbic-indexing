package DBICx::Indexing;

use strict;
use warnings;
use base qw/DBIx::Class/;

__PACKAGE__->mk_classdata('_dbicx_indexing');

sub indexes {
  my $class = shift;

  if (@_) {
    my $idxs;
    if   (scalar(@_) == 1) { $idxs = $_[0] }
    else                   { $idxs = {@_} }

    for my $cols (values %$idxs) {
      $cols = [$cols] unless ref $cols eq 'ARRAY';
    }

    $class->_dbicx_indexing($idxs);
  }

  return $class->_dbicx_indexing;
}

1;

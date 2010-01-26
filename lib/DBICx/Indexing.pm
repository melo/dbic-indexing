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

sub _has_cover_index {
  my ($table, $cols) = @_;

  my @idxs;
  push @idxs, map { [$_->fields] } $table->get_indices;
  push @idxs, map { [$_->field_names] } $table->unique_constraints;
  push @idxs, [$table->primary_key->field_names];

IDXS: for my $flst (@idxs) {
    for my $c (@$cols) {
      next IDXS unless @$flst;
      next IDXS unless $flst->[0] eq $c;

      shift @$flst;
    }

    return 1;
  }

  return 0;
}

1;

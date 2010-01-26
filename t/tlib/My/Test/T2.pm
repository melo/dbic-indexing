package My::Test::T2;

use strict;
use warnings;
use base 'DBIx::Class';

__PACKAGE__->load_components('+DBICx::Indexing', 'Core');
__PACKAGE__->table('y');

__PACKAGE__->indices(
  idx1 => 'a',
  idx2 => ['a', 'c'],
  idx3 => ['d', 'a'],
  idx4 => ['e', 'f'],
);

1;

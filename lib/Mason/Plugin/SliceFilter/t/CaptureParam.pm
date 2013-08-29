package Mason::Plugin::SliceFilter::t::CaptureParam;
use Test::Class::Most parent => 'Mason::Test::Class';
sub test_slice_filter :Test(3){
  my $self = shift;
  $self->setup_interp( plugins => [ '@Default', 'SliceFilter' ] );

  ## Just one slice without any param
  $self->test_comp( src =>
q|
% $.Slice(slice_id => 'aslice' , get_slice => sub{ return undef; } ){{
SliceA
% }}
|,
                    expect => 'SliceA');

## Hit the first slice
  $self->test_comp( src =>
q|
% $.Slice(slice_id => 'aslice' , get_slice => sub{ return 'aslice'; } ){{
SliceA
% }}
% $.Slice(slice_id => 'bslice' ){{
SliceB
% }}
|,
                    expect => 'SliceA');


## Hit the second slice
  $self->test_comp( src =>
q|
% my $get_slice = sub{ return 'bslice'};
% $.Slice(slice_id => 'aslice', get_slice => $get_slice ){{
SliceA
% }}
% $.Slice(slice_id => 'bslice', get_slice => $get_slice ){{
SliceB
% }}
|,
                    expect => 'SliceB' );

}

1;

component extends="wheels.tests.Test" {

  include "helpers.cfm";

  public void function setup() {
    config = {
      path="wheels"
      ,fileName="Mapper"
      ,method="init"
    };
    _params = {controller="test", action="index"};
    _originalRoutes = application[$appKey()].routes;
  }

  // normalizePattern

  function test_normalizePattern_no_starting_slash() {
    mapper = $mapper();
    urlString = "controller/action";
    newString = mapper.normalizePattern(urlString);
    assert('newString eq "/controller/action"');
  }

  function test_normalizePattern_double_slash_and_no_starting_slash() {
    mapper = $mapper();
    urlString = "controller//action";
    newString = mapper.normalizePattern(urlString);
    assert('newString eq "/controller/action"');
  }

  function test_normalizePattern_ending_slash_no_starting_slash() {
    mapper = $mapper();
    urlString = "controller/action/";
    newString = mapper.normalizePattern(urlString);
    assert('newString eq "/controller/action"');
  }

  function test_normalizePattern_slashes_everywhere_with_format() {
    mapper = $mapper();
    urlString = "////controller///action///.asdf/////";
    newString = mapper.normalizePattern(urlString);
    assert('newString eq "/controller/action.asdf"');
  }

  // patternToRegex

  function test_patternToRegex_root() {
    mapper = $mapper();
    pattern = "/";
    regex = mapper.patternToRegex(pattern);
    assert('regex eq "^/?$"');
  }

  function test_patternToRegex_root_with_format() {
    mapper = $mapper();
    pattern = "/.[format]";
    regex = mapper.patternToRegex(pattern);
    assert('regex eq "^\.(\w+)/?$"');
  }

  function test_patternToRegex_with_basic_catch_all_pattern() {
    mapper = $mapper();
    pattern = "/[controller]/[action]/[key].[format]";
    regex = mapper.patternToRegex(pattern);
    assert('regex eq "^([^\/]+)/([^.\/]+)/([^.\/]+)\.(\w+)/?$"');
  }

  // stripRouteVariables

  function test_stripRouteVariables_no_variables() {
    mapper = $mapper();
    pattern = "/";
    varList = mapper.stripRouteVariables(pattern);
    assert('varList eq ""');
  }

  function test_stripRouteVariables_root_with_format() {
    mapper = $mapper();
    pattern = "/.[format]";
    varList = mapper.stripRouteVariables(pattern);
    assert('varList eq "format"');
  }

  function test_stripRouteVariables_with_basic_catch_all_pattern() {
    mapper = $mapper();
    pattern = "/[controller]/[action]/[key].[format]";
    varList = mapper.stripRouteVariables(pattern);
    assert('varList eq "controller,action,key,format"');
  }

  function test_stripRouteVariables_with_nested_restful_route() {
    mapper = $mapper();
    pattern = "/posts(/[id](/comments(/[commentid](.[format]))))";
    varList = mapper.stripRouteVariables(pattern);
    assert('varList eq "id,commentid,format"');
  }
}

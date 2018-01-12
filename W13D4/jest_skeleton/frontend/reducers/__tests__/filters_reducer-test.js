import FiltersReducer from '../filters_reducer';
import * as FilterActions from '../../actions/filter_actions';
import merge from 'lodash/merge';

describe('FiltersReducer', () => {
  const defaultFilters = Object.freeze({
    bounds: {},
    minSeating: 1,
    maxSeating: 10
  });

  test('should initialize with a default state', () => {
    expect(FiltersReducer(undefined, {})).toEqual(defaultFilters);
  });

  describe('handling the UPDATE_FILTER action', () => {
    let action;
    const filter = 'filter', value = 'value';

    beforeEach(() => {
      action = FilterActions.changeFilter(filter, value);
    });

    test('should update the state with the action\'s filter and value', () => {
      const expectedResult = merge({}, defaultFilters, { [filter]: value });
      expect(FiltersReducer(defaultFilters, action)).toEqual(expectedResult);
    });

    test('should not modify the old state', () => {
      let old_state = { test: 'test' };
      FiltersReducer(old_state, action);
      expect(old_state).toEqual({ test: 'test' });
    });
  });
});

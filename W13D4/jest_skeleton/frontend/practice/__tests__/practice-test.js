import { sum, screamify } from '../practice'

describe('sum', () => {
  // can also use it()
  test('adds the two inputs together', () => {
    expect(sum(1, 2)).toEqual(3);
  });
});

describe('screamify', () => {
  test('changes string to uppercase', () => {
    expect(screamify('hello world')).toEqual('HELLO WORLD');
  });
});
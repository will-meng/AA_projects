DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  reply_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('William', 'Meng'),
  ('Linda', 'Chan'),
  ('zbob', 'Wonger');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Who is the Best TAs?', '5chars', (SELECT id FROM users WHERE fname = 'William' AND lname = 'Meng')),
  ('What is your favourite programming language?', 'I am confused, I need suggestion.', (SELECT id FROM users WHERE fname = 'Linda' AND lname = 'Chan')),
  ('Where is the best dim sum in SF?', '5chars', (SELECT id FROM users WHERE fname = 'William' AND lname = 'Meng'));

INSERT INTO
  replies (user_id, body, question_id)
VALUES (
  (SELECT id FROM users WHERE fname = 'Linda' AND lname = 'Chan'),
  'They are all great.',
  (SELECT id FROM questions WHERE title = 'Who is the Best TAs?')
);

INSERT INTO
  replies (reply_id, user_id, body, question_id)
VALUES (
  (SELECT id FROM replies WHERE body = 'They are all great.'),
  (SELECT id FROM users WHERE fname = 'William' AND lname = 'Meng'),
  'No, they are not! Just pick one.',
  (SELECT id FROM questions WHERE title = 'Who is the Best TAs?')
);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 2),
  (1, 1),
  (2, 1);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (3, 2),
  (2, 1),
  (2, 2),
  (1, 3),
  (1, 1);

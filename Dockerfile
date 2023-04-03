# Використовуємо офіційний образ Ruby з версією 3.1.2
FROM ruby:3.1.2


# Оновлюємо пакетний менеджер та встановлюємо залежності: Node.js та PostgreSQL клієнт
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libmagickwand-dev libpq-dev postgresql-client-common postgresql-client

# Встановлюємо директорію робочої області в /TodoBackend
WORKDIR /TodoBackend


# Копіюємо файли проекту Gemfile та Gemfile.lock в директорію робочої області
COPY Gemfile /TodoBackend/Gemfile
COPY Gemfile.lock /TodoBackend/Gemfile.lock

# Встановлюємо всі геми, вказані в Gemfile та Gemfile.lock
RUN bundle check || bundle install

# Додайте сценарій, який буде виконуватися щоразу, коли запускається контейнер.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh


# Встановлюємо точку входу, виконуваний скрипт entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
COPY . /TodoBackend

# Відкриваємо порт 3000 для з'єднань ззовні
EXPOSE 3000

# Команда, яка буде виконуватись при запуску контейнера
CMD ["rails", "server", "-b", "0.0.0.0"]
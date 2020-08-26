FROM jekyll/builder AS dev_builder

WORKDIR /tmp

COPY Gemfile Gemfile*.lock ./

RUN bundle install

COPY . .

ENV JEKYLL_ENV=production
RUN jekyll build

FROM nginx:alpine AS prod_serv

COPY --from=dev_builder /tmp/_site /usr/share/nginx/html

EXPOSE 80

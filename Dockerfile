FROM jekyll/builder:4 AS builder
ARG SOURCE_DIR="/pages/INTERSECT-training/CI-CD"
WORKDIR ${SOURC_DIR}
COPY Gemfile ./
RUN bundle install
# post-install stuff for jekyll-build-pages
RUN gem install faraday-retry
STOPSIGNAL SIGQUIT
CMD ["/usr/local/bundle/bin/bundle", "exec", "/usr/local/bundle/bin/jekyll", "serve", "--livereload", "--incremental"]

FROM builder as production
ARG PAGES_REPO_NWO 
COPY . .
RUN jekyll build && cp -r ./_site /build

FROM nginx:alpine AS serv
ARG SOURCE_DIR="pages/INTERSECT-training/CI-CD"
COPY --from=production /build /usr/share/nginx/html
RUN mkdir -p /usr/share/nginx/html/${SOURCE_DIR} \
    && mv /usr/share/nginx/html/assets /usr/share/nginx/html/${SOURCE_DIR}/assets

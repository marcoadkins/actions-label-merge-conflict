FROM node:12-alpine as builder

RUN mkdir -p /opt/actions-label-merge-conflict/dist

WORKDIR /opt/actions-label-merge-conflict

COPY . /opt/actions-label-merge-conflict/

RUN yarn install --frozen-lockfile && yarn run build

FROM node:12-alpine as runner

LABEL com.github.actions.name="actions-label-merge-conflict"
LABEL com.github.actions.description="A GitHub Action that auto-updates PRs when they have conflicts"
LABEL com.github.actions.icon="git-pull-request"
LABEL com.github.actions.color="blue"

RUN apk add --update --no-cache ca-certificates \
  && mkdir -p /opt/actions-label-merge-conflict

WORKDIR /opt/actions-label-merge-conflict

COPY --from=builder /opt/actions-label-merge-conflict/dist/index.js /opt/actions-label-merge-conflict/index.js

ENTRYPOINT [ "node", "/opt/actions-label-merge-conflict/index.js" ]

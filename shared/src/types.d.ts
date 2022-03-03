export type Maybe<T> = T | null;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
  DateTime: any;
};

export type Auction = {
  __typename?: 'Auction';
  description?: Maybe<Scalars['String']>;
  endsAt?: Maybe<Scalars['DateTime']>;
  id?: Maybe<Scalars['ID']>;
  title?: Maybe<Scalars['String']>;
  user?: Maybe<User>;
  userId?: Maybe<Scalars['Int']>;
};

export type AuctionInput = {
  description: Scalars['String'];
  endsAt: Scalars['DateTime'];
  title: Scalars['String'];
};


export type RootMutationType = {
  __typename?: 'RootMutationType';
  checkToken?: Maybe<User>;
  createAuction?: Maybe<Auction>;
  login?: Maybe<Session>;
};


export type RootMutationTypeCheckTokenArgs = {
  token: Scalars['String'];
};


export type RootMutationTypeCreateAuctionArgs = {
  input: AuctionInput;
};


export type RootMutationTypeLoginArgs = {
  email: Scalars['String'];
  password: Scalars['String'];
};

export type RootQueryType = {
  __typename?: 'RootQueryType';
  auctionDetails?: Maybe<Auction>;
  listAuctions?: Maybe<Array<Maybe<Auction>>>;
  me?: Maybe<User>;
  popularAuctions?: Maybe<Array<Maybe<Auction>>>;
};


export type RootQueryTypeAuctionDetailsArgs = {
  id: Scalars['Int'];
};


export type RootQueryTypeListAuctionsArgs = {
  limit?: Maybe<Scalars['Int']>;
};

export type Session = {
  __typename?: 'Session';
  token?: Maybe<Scalars['String']>;
  user?: Maybe<User>;
};

export type User = {
  __typename?: 'User';
  auctions?: Maybe<Array<Maybe<Auction>>>;
  email?: Maybe<Scalars['String']>;
  id?: Maybe<Scalars['ID']>;
  money?: Maybe<Scalars['Int']>;
  name?: Maybe<Scalars['String']>;
};

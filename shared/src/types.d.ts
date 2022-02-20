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

export type AuctionItemInput = {
  description: Scalars['String'];
  endsAt: Scalars['DateTime'];
  title: Scalars['String'];
};


export type Item = {
  __typename?: 'Item';
  description?: Maybe<Scalars['String']>;
  endsAt?: Maybe<Scalars['DateTime']>;
  id?: Maybe<Scalars['ID']>;
  title?: Maybe<Scalars['String']>;
};

export type RootMutationType = {
  __typename?: 'RootMutationType';
  createAuctionItem?: Maybe<Item>;
};


export type RootMutationTypeCreateAuctionItemArgs = {
  input: AuctionItemInput;
};

export type RootQueryType = {
  __typename?: 'RootQueryType';
  itemDetails?: Maybe<Item>;
  listItems?: Maybe<Array<Maybe<Item>>>;
  popularItems?: Maybe<Array<Maybe<Item>>>;
};


export type RootQueryTypeItemDetailsArgs = {
  id: Scalars['Int'];
};


export type RootQueryTypeListItemsArgs = {
  limit?: Maybe<Scalars['Int']>;
};
